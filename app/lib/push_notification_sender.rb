require 'gcm'

class PushNotificationSender
  def initialize
    @client = GCM.new(ENV['GCM_API_KEY'])
  end

  def send_all
    registration_ids = RegistrationIdListFactory.build

    @client.send(registration_ids, {})
  end
end
