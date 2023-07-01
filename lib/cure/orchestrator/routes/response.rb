# frozen_string_literal: true

module Cure
  module Orchestrator
    module Response

      def success(obj)
        {
          success: true,
          content: obj,
          route: request.env.fetch("sinatra.route", "<unknown>")
        }
      end

      def error(obj)
        {
          success: false,
          content: obj,
          route: request.env.fetch("sinatra.route", "<unknown>")
        }
      end

    end
  end
end
