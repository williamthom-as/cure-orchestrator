# frozen_string_literal: true

module Cure
  module Orchestrator
    module Routes
      class PostJob < BaseRoute

        def call
          job_spec = parsed_request

          job = Cure::Orchestrator::Models::Job.create(
            name: job_spec.fetch("name", "<unknown>"),
            job_type: "CureTransform",
            job_args: {
              input_file: job_spec["input_file"],
              template_file: job_spec["template_file"],
              start_time: job_spec.fetch("start_date", nil)
            }.to_json,
            status: "pending"
          )

          success({job: job.values, message: "Job posted!"})
        end
      end
    end
  end
end
