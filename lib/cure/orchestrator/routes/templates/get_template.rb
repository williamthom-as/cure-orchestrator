# frozen_string_literal: true

module Cure
  module Orchestrator
    module Routes
      class GetTemplate < BaseRoute

        def initialize(request, params, config_service: Services::ConfigurationService.new)
          @config_service = config_service
          super(request, params)
        end

        def call
          directory = @config_service.config_file.fetch("template_directory")
          template = File.read("#{directory}/#{@params[:name]}")

          success({template: template})
        end
      end
    end
  end
end
