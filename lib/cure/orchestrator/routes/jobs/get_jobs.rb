# frozen_string_literal: true

module Cure
  module Orchestrator
    module Routes
      class GetJobs < BaseRoute

        def call
          jobs = Cure::Orchestrator::Models::Job.all.map(&:values)
          success({jobs: jobs, message: "Successfully got jobs"})
        end
      end
    end
  end
end
