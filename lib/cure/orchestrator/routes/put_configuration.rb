# frozen_string_literal: true

require "yaml"

module Cure
  module Orchestrator
    module Routes
      class PutConfiguration < BaseRoute

        CONFIG_FILE_LOCATION = "/etc/cure/config.json"

        REQUIRED_CONF_KEYS = %w[
          input_directory
          template_directory
        ].freeze

        def call
          params = parsed_request

          if (params.keys - REQUIRED_CONF_KEYS) != []
            return error({message: "Invalid properties passed to configuration #{[params.keys - REQUIRED_CONF_KEYS]}"})
          end

          write_config_file(params)

          success({message: "Configuration is saved."})
        end

        private

        def write_config_file(content)
          File.open(CONFIG_FILE_LOCATION, "w") do |f|
            f.write(content.to_json)
          end
        end
      end
    end
  end
end

