class Amazon::ProductAdvertisingService
  def initialize
    @request = Vacuum.new('JP')

    @request.associate_tag = ENV['AMAZON_ASSOCIATE_TAG']
    # ASW_ACCESS_KEY_ID と AWS_SECRET_ACCESS_KEY は
    # gem が環境変数の値を勝手に使ってくれる
  end

  def search_item(title)
    try_count = 0
    response = nil

    begin
      try_count += 1
      response = @request.item_search(
        query: {
          'Keywords' => title,
          'SearchIndex' => 'Books'
        }
      )
    rescue Excon::Error::ServiceUnavailable => error
      sleep_duration = 2 ** try_count
      Rails.logger.info("Excon::Error::ServiceUnavailable raised. (try_count: #{try_count})")

      sleep(sleep_duration)
      retry if try_count <= 10
      raise error
    end

    items = case response.dig('ItemSearchResponse', 'Items', 'TotalResults').to_i
            when 0
              []
            when 1
              [response.dig('ItemSearchResponse', 'Items', 'Item')]
            else
              response.dig('ItemSearchResponse', 'Items', 'Item')
            end

    return nil if items.count == 0

    items.first
  end
end
