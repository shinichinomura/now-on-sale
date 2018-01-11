class ServiceWorkerPushSubscription < ApplicationRecord
  belongs_to :user
  has_many :push_notifications
end
