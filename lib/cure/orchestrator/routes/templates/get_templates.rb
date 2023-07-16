# frozen_string_literal: true

module Cure
  module Orchestrator
    module Routes
      class GetTemplates < BaseRoute

        def initialize(request, params, config_service: Services::ConfigurationService.new)
          @config_service = config_service
          super(request, params)
        end

        def call
          directory = @config_service.config_file.fetch("template_directory")
          templates = Dir.glob("#{directory}/*.rb").map do |file_path|
            {
              name: File.basename(file_path),
              c_time: File.ctime(file_path),
              path: file_path
            }
          end

          success({templates: templates, message: "test"})
        end
      end
    end
  end
end
