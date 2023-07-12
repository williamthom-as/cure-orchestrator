# frozen_string_literal: true

require "cure/orchestrator/server"

module Cure
  module Orchestrator
    module Models
      module ModelHelpers
        def app_config
          Orchestrator::Server.settings.app_config
        end
      end
    end
  end
end
