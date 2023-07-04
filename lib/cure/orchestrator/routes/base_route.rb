# frozen_string_literal: true

require "cure/orchestrator/routes/response"

module Cure
  module Orchestrator
    module Routes
      class BaseRoute
        include Response

        attr_reader :request

        # @param [Sinatra::Request] request
        def initialize(request)
          @request = request
        end

        def call
          raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end

        private

        def parsed_request
          body = request.body.read
          return {} unless body

          JSON.parse(body)
        end
      end
    end
  end
end
