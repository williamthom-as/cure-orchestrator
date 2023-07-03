# frozen_string_literal: true

require "cure/orchestrator/version"
require "cure/orchestrator/server"

module Cure
  module Orchestrator
    class Error < StandardError; end

    def self.start
      Cure::Orchestrator::Server.run!
    end
  end
end

Cure::Orchestrator.start
