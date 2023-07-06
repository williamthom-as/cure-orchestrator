# frozen_string_literal: true

module Cure
  module Orchestrator
    module Services
      class ConfigurationService

        CONFIG_FILE_LOCATION = "/etc/cure/config.json"

        def validate_config_file
          results = {}

          config = config_file
          raise "Missing config" unless config

          %w[input_directory template_directory database_file_location].each do |location|
            if File.exist?(config[location.to_s])
              results[location.to_sym] = {valid: true, message: "[#{location}] is present"}
              next
            end

            results[location.to_sym] = {valid: false, message: "[#{location}] is missing"}
          end

          results
        end

        def config_file
          return nil unless File.exist? CONFIG_FILE_LOCATION

          JSON.parse(File.read(CONFIG_FILE_LOCATION))
        end
      end
    end
  end
end
