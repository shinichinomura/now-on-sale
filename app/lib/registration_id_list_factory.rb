class RegistrationIdListFactory
  def self.build
    PushNotification.
      joins(:service_worker_push_subscription).
      left_joins(:fetch_logs).
      where(push_notification_fetch_logs: { id: nil }).
      pluck(:registration_id)
  end
end
