class CreatePushNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :push_notifications do |t|
      t.integer :subscription_id, null: false, limit: 8
      t.integer :publication_id, null: false, limit: 8

      t.timestamps
    end

    add_foreign_key :push_notifications, :service_worker_push_subscriptions, column: :subscription_id, on_delete: :cascade, on_update: :cascade
    add_foreign_key :push_notifications, :publications, on_delete: :cascade, on_update: :cascade
  end
end
