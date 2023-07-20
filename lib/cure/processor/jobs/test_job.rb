# frozen_string_literal: true

require "cure/processor/jobs/base_job"

module Cure
  module Processor
    class TestJob < BaseJob
      def _perform(_args)
        puts "In test!"
      end
    end
  end
end
