class CreatePushNotificationFetchLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :push_notification_fetch_logs do |t|
      t.integer :push_notification_id, null: false, limit: 8

      t.timestamps
    end

    add_foreign_key :push_notification_fetch_logs, :push_notifications, on_delete: :cascade, on_update: :cascade
  end
end
