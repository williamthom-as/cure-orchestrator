# frozen_string_literal: true

module Cure
  module Processor

    # This is just a marker class basically
    class BaseJob

      def perform(job)
        puts "-- #{job.id} #{job.status} status"

        job.update_status("complete")

        puts "-- #{job.id} #{job.status} status"
      end

      def _perform(_args)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end
    end
  end
end
