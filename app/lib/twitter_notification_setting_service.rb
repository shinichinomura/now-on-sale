class TwitterNotificationSettingService
  def initialize(user)
    @user = user
  end

  def enabled?
    TwitterNotificationSetting.find_by_user_id(@user.id).present?
  end

  def disabled?
    !enabled?
  end

  def enable!
    if enabled?
      false
    else
      @user.create_twitter_notification_setting!(
        nickname: @user.twitter_auth.nickname
      )
    end
  end

  def disable!
    if disabled?
      false
    else
      TwitterNotificationSetting.find_by_user_id(@user.id).destroy!
    end
  end
end
