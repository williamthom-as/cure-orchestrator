# frozen_string_literal: true

module Cure
  module Orchestrator
    module Routes
      class GetJobs < BaseRoute

        def call
          jobs = Cure::Orchestrator::Models::Job.all_with_runs
          success({jobs: jobs, message: "Successfully got jobs"})
        end
      end
    end
  end
end
