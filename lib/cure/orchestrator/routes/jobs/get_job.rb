# frozen_string_literal: true

module Cure
  module Orchestrator
    module Routes
      class GetJob < BaseRoute

        def call
          job = Cure::Orchestrator::Models::Job.with_pk!(params[:id])

          return error({job: nil, message: "Could not find job #{params[:id]}"}) unless job

          success({job: job.values, message: "Successfully got job"})
        end
      end
    end
  end
end
