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
      @twitter_client.update("@#{@user.twitter_auth.nickname} 今日は「#{publication.title}」の発売日だよ。")
    end
  end
end
