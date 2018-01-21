class ServiceWorkerPushSubscriptionDecorator < Draper::Decorator
  delegate_all

  def ip_address
    histories.find_by_action('create').ip_address
  end

  def user_agent
    histories.find_by_action('create').user_agent
  end
end
