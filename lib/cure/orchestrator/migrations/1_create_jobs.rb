require "sequel"

Sequel.migration do
  change do
    create_table :jobs do
      primary_key :id
      String :name
      String :template_file, null: false
      String :input_file, null: false
      String :status, null: false
      Integer :error_count, null: false, default: 0
      String :last_error_message
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, index: true
      DateTime :updated_at
    end
  end
end
