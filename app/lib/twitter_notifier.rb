class TwitterNotifier
  def initialize(user_id:)
    @user = User.find(user_id)

    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_API_KEY"]
      config.consumer_secret = ENV["TWITTER_API_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def notify(publications)
    publications.each do |publication|
      status_parts = []
      status_parts << "@#{@user.twitter_notification_setting.nickname}"
      status_parts << "今日は「#{publication.title}」の発売日だよ。"

      if publication.amazon_item_attribute.present?
        status_parts << publication.amazon_item_attribute.detail_page_url
      end

      @twitter_client.update(status_parts.join(' '))
    end
  end
end
