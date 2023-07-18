# frozen_string_literal: true

require "sequel"

module Cure
  module Orchestrator

    class Helpers
      def self.init_database(app_config)
        database =
          if ENV["RACK_ENV"] == "test"
            Sequel.sqlite(ENV["RACK_TEST_DB_LOCATION"])
          else
            Sequel.sqlite(app_config.fetch("database_file_location", nil))
          end

        Sequel.extension :migration

        Sequel::Migrator.run(
          database,
          File.join(File.dirname(__FILE__), "migrations"),
          use_transactions: true
        )

        database
      end
    end
  end
end
