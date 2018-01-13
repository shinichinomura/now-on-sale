class PushNotification < ApplicationRecord
  belongs_to :service_worker_push_subscription
  has_many :fetch_logs, class_name: 'PushNotificationFetchLog'
  belongs_to :publication
end
