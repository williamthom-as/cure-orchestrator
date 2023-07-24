# frozen_string_literal: true

require "cure/orchestrator/routes/base_route"

Dir[File.join(File.dirname(__FILE__), "**/*.rb")].each do |file_path|
  require file_path
end
