class User < ApplicationRecord
  has_one :twitter_auth

  has_many :subscriptions
end