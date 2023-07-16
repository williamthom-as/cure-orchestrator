# frozen_string_literal: true

require "json"

require "cure/orchestrator/models/model_helpers"

module Cure
  module Orchestrator
    module Routes
      class GetConfiguration < BaseRoute
        include Orchestrator::Models::ModelHelpers

        def initialize(request, params, config_service: Services::ConfigurationService.new)
          @config_service = config_service
          super(request, params)
        end

        def call
          ret = @config_service.config_file

          unless ret
            return success({
              config_file: nil, message: "No config file found at #{CONFIG_FILE_LOCATION}"
            })
          end

          success({config_file: ret, message: "Configuration is valid."})
        end
      end
    end
  end
end

