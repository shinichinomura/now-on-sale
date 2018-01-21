class User < ApplicationRecord
  has_one :twitter_auth

  has_many :subscriptions

  has_many :service_worker_push_subscriptions

  has_one :twitter_notification_setting
end
