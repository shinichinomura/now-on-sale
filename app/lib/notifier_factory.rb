class NotifierFactory
  def initialize(user_id:)
    @user_id = user_id
  end

  def notifiers
    [
      TwitterNotifier.new(user_id: @user_id),
      ServiceWorkerPushNotifier.new(user_id: @user_id)
    ]
  end
end
