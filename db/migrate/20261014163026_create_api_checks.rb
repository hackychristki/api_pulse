class CreateApiChecks < ActiveRecord::Migration[8.1]
  def change
    create_table :api_checks do |t|
      t.references :monitored_api, null: false, foreign_key: true
      t.integer :http_status
      t.integer :response_time_ms
      t.datetime :checked_at, null: false
      t.text :error_message
      t.boolean :online, null: false, default: false

      t.timestamps
    end
  end
end