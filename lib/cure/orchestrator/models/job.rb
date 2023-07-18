# frozen_string_literal: true

require "sequel"

module Cure
  module Orchestrator
    module Models
      class Job < Sequel::Model(:jobs)
        one_to_many :job_runs, key: :job_id

        def self.next_pending_job
          where(status: "pending").order(:created_at).first
        end

        def update_status(status)
          update(status: status, updated_at: DateTime.now)
        end
      end
    end
  end
end

