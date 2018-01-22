class PushNotificationFactory
  def self.create!(user:, publication:)
    service_worker_push_subscriptions = ServiceWorkerPushSubscription.where(user_id: user.id).enabled

    service_worker_push_subscriptions.each do |subscription|
      PushNotification.create!(service_worker_push_subscription_id: subscription.id, publication_id: publication.id)
    end
  end
end
