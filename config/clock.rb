require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job|
    Rails.logger.info("Running #{job}")
  end

  every(1.day, 'notify publications', at: '10:00') do
    PublicationNotifier.notify_all
  end

  every(1.day, 'send push notifications', at: '10:00') do
    PushNotificationSender.new.send_all
  end

  every(1.day, 'update publications in this month') do
    date = Date.current
    PublicationUpdater.new(year: date.year, month: date.month).update!
  end

  every(1.week, 'update publications in next month') do
    date = Date.current.next_month
    begin
      PublicationUpdater.new(year: date.year, month: date.month).update!
    rescue OpenURI::HTTPError
      Rails.logger.info("#{date.strftime('%Y年%m月')}の新刊情報が見つかりません。")
    end
  end
end 
