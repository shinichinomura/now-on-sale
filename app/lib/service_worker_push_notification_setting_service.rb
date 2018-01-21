class ServiceWorkerPushNotificationSettingService
  def initialize(subscription)
    @subscription = subscription
  end

  def enable!
    @subscription.enabled = true
    @subscription.save!
  end

  def disable!
    @subscription.enabled = false
    @subscription.save!
  end
end
