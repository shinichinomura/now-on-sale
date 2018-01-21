class ServiceWorkerPushNotificationSettingsController < ApplicationController
  def update
    form = Form::ServiceWorkerPushNotificationSettingForm.new(
      subscriptions: @current_user.service_worker_push_subscriptions
    )
    form.save!(params)

    redirect_to :settings, notice: '設定を保存しました。'
  end
end
