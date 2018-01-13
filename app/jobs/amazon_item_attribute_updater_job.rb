class AmazonItemAttributeUpdaterJob < ApplicationJob
  queue_as :default

  def perform(publication)
    Amazon::ItemAttributeUpdater.new(publication).update!
  end
end
