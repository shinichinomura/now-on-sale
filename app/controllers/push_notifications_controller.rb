class PushNotificationsController < ApplicationController
  def shift
    subscription = ServiceWorkerPushSubscription.find_by_registration_id(params[:registration_id])

    notification = PushNotification.
      left_joins(:fetch_logs).
      where(service_worker_push_subscription_id: subscription.id).
      where(push_notification_fetch_logs: { id: nil }).
      first

    title = 'NowOnSale'

    if notification.present?
      notification.fetch_logs.create!
      body = "今日は#{notification.publication.title}の発売日です。"
    end

    render json: {
      'title': title,
      'body': body
    }
  end
end
