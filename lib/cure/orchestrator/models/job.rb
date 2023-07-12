# frozen_string_literal: true

require "sequel"

module Cure
  module Orchestrator
    module Models
      class Job < Sequel::Model(:jobs)
        one_to_many :job_runs, key: :job_id
      end
    end
  end
end

