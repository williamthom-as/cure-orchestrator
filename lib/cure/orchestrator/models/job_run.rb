# frozen_string_literal: true

require "sequel"

module Cure
  module Orchestrator
    module Models
      class JobRun < Sequel::Model(:job_runs)
        many_to_one :job, key: :job_id

        def self.create_new(job)
          create(
            job: job,
            status: "started",
            created_at: DateTime.now,
            updated_at: DateTime.now
          )
        end

        def self.all_for_job(job)
          where(job_id: job[:id]).all.map(&:values)
        end

        def mark_complete
          update(
            status: "complete",
            updated_at: DateTime.now
          )
        end

        def mark_error(error_class, error_message)
          update(
            status: "error",
            error_message: "[#{error_class}]: #{error_message}",
            updated_at: DateTime.now
          )
        end

      end
    end
  end
end

