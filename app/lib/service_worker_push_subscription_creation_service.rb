class ServiceWorkerPushSubscriptionCreationService
  def self.create!(user_id:, registration_id:, request:)
    if ServiceWorkerPushSubscription.find_by_registration_id(registration_id).present?
      false
    else
      ServiceWorkerPushSubscription.transaction do
        subscription = ServiceWorkerPushSubscription.create!(
          user_id: user_id,
          registration_id: registration_id
        )

        subscription.histories.create!(
          action: 'create',
          user_agent: request.user_agent,
          ip_address: request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
        )
      end

      true
    end
  end
end
