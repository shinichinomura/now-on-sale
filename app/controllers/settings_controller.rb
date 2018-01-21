class SettingsController < ApplicationController
  def index
    @twitter_notification_enabled = TwitterNotificationSettingService.new(@current_user).enabled?

    @push_subscription_form = Form::ServiceWorkerPushNotificationSettingForm.new(
      subscriptions: @current_user.service_worker_push_subscriptions
    )

    @push_subscriptions = @current_user.service_worker_push_subscriptions.includes(:histories).decorate
  end
end
