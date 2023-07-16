# frozen_string_literal: true

require "sequel"

module Cure
  module Orchestrator
    module Models
      class JobRun < Sequel::Model(:job_runs)
        many_to_one :job, key: :job_id
      end
    end
  end
end

