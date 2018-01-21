class AddEnabledToServiceWorkerPushSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :service_worker_push_subscriptions, :enabled, :boolean, default: true, after: :registration_id
  end
end
