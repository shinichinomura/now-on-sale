class PublicationNotifier
  def self.notify_all
    User.find_each do |user|
      self.new(user_id: user.id).notify
    end
  end

  def initialize(date: Date.current, user_id:)
    @date = date
    @user = User.find(user_id)
  end

  def notify
    notifiers = NotifierFactory.new(user_id: @user.id).notifiers
    publications = publications_to_be_notified

    notifiers.each do |notifier|
      notifier.notify(publications)
    end
  end

  private

  def publications_to_be_notified
    Publication.
      joins(serial: [:subscriptions]).
      where(date_min: @date, subscriptions: { user_id: @user.id })
  end
end
