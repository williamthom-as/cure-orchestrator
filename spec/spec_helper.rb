# frozen_string_literal: true

DATABASE_LOCATION = "spec/test.sql"

ENV["RACK_ENV"] = "test"
ENV["RACK_TEST_DB_LOCATION"] = DATABASE_LOCATION

require "sequel"
require "cure/orchestrator"
require "cure/orchestrator/routes/init"
require "cure/orchestrator/services/init"
require "cure/orchestrator/models/init"


RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after(:each) do
    Cure::Orchestrator::Models::JobRun.truncate
    Cure::Orchestrator::Models::Job.truncate
  end
end

