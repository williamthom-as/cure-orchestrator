# frozen_string_literal: true

require "timeout"
require "cure/processor/job"
require "cure/orchestrator/helpers"
require "cure/orchestrator/models/job"

module Cure
  module Processor
    class Server

      def initialize(
        process_limit: 2,
        sleep_seconds: 5,
        time_out_seconds: 3600
      )
        @pids = []
        @config = {
          process_limit: process_limit,
          sleep_seconds: sleep_seconds,
          time_out_seconds: time_out_seconds
        }
      end

      def start # rubocop:disable Metrics/AbcSize
        boot_init

        loop do
          # Check if all processes are taken, sleep
          if @config[:process_limit] == @pids.size
            puts "waiting for pids to release"

            sleep(@config[:sleep_seconds])
            redo
          end

          # Attempt to get work
          job = nil
          database_mutex.synchronize do
            job = retrieve_job
          end

          # Sleep if no work
          unless job
            puts "No work... going to sleep"
            sleep @config[:sleep_seconds]
            redo
          end


          # Work found, queue job
          job.update_status("started")
          pid = fork do
            Timeout.timeout(@config[:time_out_seconds]) do
              puts "Queueing job #{job.name}"
              Cure::Processor::Job.new.perform(job, @database)
            end
          end

          # Add to pids safely
          pids_mutex.synchronize do
            @pids << pid
          end

          # Spawn new thread to watch process and kill once done.
          Thread.new do
            Process.wait(pid)

            pids_mutex.synchronize do
              @pids.delete(pid)
            end
          end

          sleep 1
        end
      rescue SignalException => _e
        puts "Shutting down gracefully..."
        shut_down
      end

      private

      def boot_init
        # When there are more than a few tasks,
        # this should be broken out into classes.
        config = JSON.parse(File.read("/etc/cure/config.json"))
        @database = Cure::Orchestrator::Helpers.init_database(config["database_file_location"])
      end

      def shut_down
        return if @pids.empty?

        puts "Killing #{@pids.size} existing running pids"
        @pids.each { |pid| Process.kill(9, pid) }
      end

      def retrieve_job
        # this will connect to db
        Cure::Orchestrator::Models::Job.next_pending_job
      end

      def pids_mutex
        @pids_mutex ||= Mutex.new
      end

      def database_mutex
        @database_mutex ||= Mutex.new
      end
    end
  end
end
