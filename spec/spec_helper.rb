# frozen_string_literal: true

require "sequel"
require "cure/orchestrator"
require "cure/orchestrator/routes/init"
require "cure/orchestrator/services/init"

# Init in-memory DB
DB = Sequel.sqlite

# Perf migrations
Sequel.extension :migration
Sequel::Migrator.run(
  DB,
  "lib/cure/orchestrator/migrations",
  use_transactions: true
)

require "cure/orchestrator/models/init"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

