class CreateMonitoredApis < ActiveRecord::Migration[8.1]
  def change
    create_table :monitored_apis do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.integer :expected_status, null: false, default: 200

      t.timestamps
    end
  end
end
