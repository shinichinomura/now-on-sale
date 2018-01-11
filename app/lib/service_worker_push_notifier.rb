class ServiceWorkerPushNotifier
  def initialize(user_id:)
    @user = User.find(user_id)
  end

  def notify(publications)
    publications.each do |publication|
      PushNotificationFactory.create!(user: @user, publication: publication)
    end
  end
end
