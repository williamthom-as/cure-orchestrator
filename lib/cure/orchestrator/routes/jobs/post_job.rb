# frozen_string_literal: true

module Cure
  module Orchestrator
    module Routes
      class PostJob < BaseRoute

        def call
          job_reqs = parsed_request

          job = Cure::Orchestrator::Models::Job.create(
            name: "TestJob",
            job_args: "{}",
            status: "pending"
          )

          success({job: job.to_h, message: "Job posted!"})
        end
      end
    end
  end
end
