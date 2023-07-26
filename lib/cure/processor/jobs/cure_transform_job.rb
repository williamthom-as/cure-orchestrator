# frozen_string_literal: true

require "cure/processor/jobs/base_job"
require "cure"

module Cure
  module Processor
    class CureTransformJob < BaseJob
      def _perform(job)
        args = JSON.parse(job.job_args)

        Cure.init_from_file(args["template_file"])
            .with_csv_file(:pathname, Pathname.new(args["input_file"]))
            .setup
            .run_export
      end
    end
  end
end
