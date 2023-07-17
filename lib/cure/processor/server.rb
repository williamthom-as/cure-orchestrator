# frozen_string_literal: true

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
        loop do
          # Check if all processes are taken, sleep
          if @config[:process_limit] == @pids.size
            puts "waiting for pids to release"

            sleep(@config[:sleep_seconds])
            redo
          end

          # Attempt to get work
          job_args = retrieve_job

          # Sleep if no work
          unless job_args
            sleep @config[:sleep_seconds]
            redo
          end

          # Work found, queue job
          pid = fork do
            puts "Queueing job #{job_args}"
            Job.new.perform(job_args)
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
        end
      rescue SignalException => _se
        puts "Shutting down gracefully..."
      end

      private

      def retrieve_job
        # this will connect to db
        @test ||= ['a','b','c', 'd', 'e']
      end

      def shut_down
        # If any pids still running, issue kill
      end

      def pids_mutex
        @pids_mutex ||= Mutex.new
      end
    end

    require "securerandom"

    class Job

      def perform(args)
        sleep(rand(2..6))
        exit 130
      end

    end
  end
end

svr = Cure::Processor::Server.new
svr.start