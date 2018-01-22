class NotifierFactory
  def initialize(user:)
    @user = user
  end

  def notifiers
    list = []

    if @user.twitter_notification_setting.present?
      list << TwitterNotifier.new(user_id: @user.id) 
    end

    if @user.service_worker_push_subscriptions.enabled.present?
      list << ServiceWorkerPushNotifier.new(user_id: @user.id)
    end

    list
  end
end
