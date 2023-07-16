# frozen_string_literal: true

module Cure
  module Orchestrator
    module Routes
      class PostJob < BaseRoute

        def initialize(request, params)
          super(request, params)
        end

        def call
          job_reqs = parsed_request

          success({template: template})
        end
      end
    end
  end
end
