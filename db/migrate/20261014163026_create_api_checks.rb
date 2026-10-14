class CreateApiChecks < ActiveRecord::Migration[8.1]
  def change
    create_table :api_checks do |t|
      t.references :monitored_api, null: false, foreign_key: true
      t.integer :http_status
      t.integer :response_time_ms
      t.datetime :checked_at
      t.text :error_message
      t.boolean :online

      t.timestamps
    end
  end
end
