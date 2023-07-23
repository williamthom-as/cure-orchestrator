# frozen_string_literal: true

module Cure
  module Orchestrator
    module Routes
      class GetJob < BaseRoute

        def call
          job = Cure::Orchestrator::Models::Job.eager(:job_runs).with_pk!(params[:id])

          return error({job: nil, message: "Could not find job #{params[:id]}"}) unless job

          result = job.values
          result[:job_args] = JSON.parse(job.job_args || "{}")
          result[:job_runs] = Cure::Orchestrator::Models::JobRun.all_for_job(job)

          success({job: result, message: "Successfully got job"})
        end
      end
    end
  end
end
