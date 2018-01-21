class TwitterNotificationSettingsController < ApplicationController
  def update
    if params[:twitter_notification]
      TwitterNotificationSettingService.new(@current_user).enable!
    else
      TwitterNotificationSettingService.new(@current_user).disable!
    end

    redirect_to :settings, notice: '設定を保存しました。'
  end
end
