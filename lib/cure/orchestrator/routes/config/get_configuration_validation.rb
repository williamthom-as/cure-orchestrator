# frozen_string_literal: true

require "json"

module Cure
  module Orchestrator
    module Routes
      class GetConfigurationValidation < BaseRoute

        def initialize(request, params, config_service: Services::ConfigurationService.new)
          @config_service = config_service
          super(request, params)
        end

        def call
          checks = @config_service.validate_config_file

          result = {}
          result[:checks] = checks
          result[:status] = checks.values.all? { |x| x[:valid] == true }

          success({result: result, message: "Configuration validation complete."})
        end
      end
    end
  end
end

