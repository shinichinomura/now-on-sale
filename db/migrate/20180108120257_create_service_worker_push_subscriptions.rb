class CreateServiceWorkerPushSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :service_worker_push_subscriptions do |t|
      t.references :user, null: false, limit: 8
      t.string :registration_id, null: false, limit: 256

      t.timestamps
    end

    add_index :service_worker_push_subscriptions, [:user_id, :registration_id], unique: true, name: 'index_sw_push_subscriptions_on_user_id_and_registration_id'
    add_foreign_key :service_worker_push_subscriptions, :users, on_delete: :cascade, on_update: :cascade
  end
end
