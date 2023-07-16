require "sequel"

Sequel.migration do
  change do
    create_table :job_runs do
      primary_key :id
      foreign_key :job_id, :jobs, null: false
      String :status, null: false
      String :error_message
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, index: true
      DateTime :updated_at
    end
  end
end
