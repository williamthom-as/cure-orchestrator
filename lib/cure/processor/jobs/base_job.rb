# frozen_string_literal: true

require "cure/orchestrator/models/job_run"

module Cure
  module Processor

    # This is just a marker class basically
    class BaseJob

      def perform(job)
        log_job_run(job) do
          _perform(job)
        end

        job.mark_complete

      rescue StandardError => e
        job.mark_error(e.class, e.message)
      end

      def _perform(_job)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      private

      def log_job_run(job, &block)
        run = Cure::Orchestrator::Models::JobRun.create_new(job)

        yield if block

        run.mark_complete
      rescue StandardError => e
        run&.mark_error(e.class, e.message)
        raise e
      end
    end
  end
end
