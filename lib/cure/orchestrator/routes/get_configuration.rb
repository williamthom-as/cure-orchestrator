# frozen_string_literal: true

require "yaml"

module Cure
  module Orchestrator
    module Routes
      class GetConfiguration < BaseRoute

        CONFIG_FILE_LOCATION = "/etc/cure/config.json"

        def call
          ret = config_file
          unless ret
            return success({
              config_file: nil, message: "No config file found at #{CONFIG_FILE_LOCATION}"
            })
          end

          success({config_file: ret, message: "Configuration is valid."})
        end

        private

        def config_file
          return nil unless File.exist? CONFIG_FILE_LOCATION

          YAML.safe_load(File.read(CONFIG_FILE_LOCATION))
        end
      end
    end
  end
end

