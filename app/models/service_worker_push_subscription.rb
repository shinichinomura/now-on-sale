class ServiceWorkerPushSubscription < ApplicationRecord
  belongs_to :user

  has_many :push_notifications

  has_many :histories,
    class_name: 'ServiceWorkerPushSubscriptionHistory'

  scope :enabled, -> { where(enabled: true) }
end
