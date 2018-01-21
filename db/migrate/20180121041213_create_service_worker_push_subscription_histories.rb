class CreateServiceWorkerPushSubscriptionHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :service_worker_push_subscription_histories do |t|
      t.integer :service_worker_push_subscription_id, null: false, limit: 8
      t.string :action, null: false, limit: 16
      t.string :user_agent, null: false, limit: 256
      t.string :ip_address, null: false, limit: 16

      t.timestamps
    end

    add_foreign_key :service_worker_push_subscription_histories, :service_worker_push_subscriptions, on_delete: :cascade, on_update: :cascade
  end
end
