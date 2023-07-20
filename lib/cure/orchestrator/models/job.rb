# frozen_string_literal: true

require "sequel"

module Cure
  module Orchestrator
    module Models
      class Job < Sequel::Model(:jobs)
        one_to_many :job_runs, key: :job_id

        class << self
          def all_with_runs
            Cure::Orchestrator::Models::Job.eager(:job_runs).all.map do |job|
              values = job.values
              values[:job_runs] = job.associations[:job_runs]
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
      end
    end
  end
end

