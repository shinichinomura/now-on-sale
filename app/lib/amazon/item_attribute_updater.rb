module Amazon
  class ItemAttributeUpdater
    def initialize(publication)
      @publication = publication
    end

    def update!
      item = ProductAdvertisingService.new.search_item(@publication.title)

      return false if item.nil?

      AmazonItemAttribute.find_or_initialize_by(publication_id: @publication.id) do |attribute|
        attribute.asin = item['ASIN']
        attribute.detail_page_url = item['DetailPageURL']
      end.save!
    end
  end
end
