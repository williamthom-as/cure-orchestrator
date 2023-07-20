# frozen_string_literal: true

require "timeout"

require "cure/processor/jobs/init"

require "cure/orchestrator/helpers"
require "cure/orchestrator/models/job"

module Cure
  module Processor
    class Server

      def initialize(
        process_limit: 2,
        sleep_seconds: 60,
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
        loop do
          # Check if all processes are taken, sleep
          if @config[:process_limit] == @pids.size
            puts "waiting for pids to release"

            sleep @config[:sleep_seconds]
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

              handler = Kernel.const_get("Cure::Processor::#{job.job_type}Job").new
              handler.perform(job)
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
        puts "Processing server shutting down gracefully..."
        shut_down
      end

      def shut_down
        return if @pids.empty?

        puts "Killing #{@pids.size} existing running pids"
        @pids.each { |pid| Process.kill(9, pid) }
      end

      private

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
