# frozen_string_literal: true

require "sequel"

module Cure
  module Orchestrator
    module Models
      class Job < Sequel::Model(:jobs)
        one_to_many :job_runs, key: :job_id, on_delete: :destroy

        class << self
          def all_with_runs
            eager(:job_runs).all.map do |job|
              values = job.values
              values[:job_runs] = job.associations[:job_runs].map(&:values)
              values
            end
          end

          def next_pending_job
            where(status: "pending").order(:created_at).first
          end
        end

        def update_status(status)
          update(status: status, updated_at: DateTime.now)
        end

        def mark_complete
          update(
            status: "complete",
            error_count: 0,
            last_error_message: nil,
            updated_at: DateTime.now
          )
        end

        def mark_error(error_class, error_message)
          update(
            status: "error",
            error_count: self.error_count + 1,
            last_error_message: "[#{error_class}]: #{error_message}",
            updated_at: DateTime.now
          )
        end
      end
    end
  end
end

