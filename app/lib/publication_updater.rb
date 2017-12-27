require 'open-uri'
require 'mechanize'
require 'json'

class PublicationUpdater
  BASE_URI = "https://books.rakuten.co.jp/event/book/comic/calendar"
  BOM_UTF_8 = "\xEF\xBB\xBF"

  class RakutenBookPublicationItem
    attr_reader :date_min, :date_max, :title, :author_name, :label

    # params [Date] date_min
    # params [Date] date_max
    # params [String] title
    # params [String] author_name
    # params [String] label
    def initialize(date_min:, date_max:, title:, author_name:, label:)
      @date_min = date_min
      @date_max = date_max
      @title = title
      @author_name = author_name
      @label = label
    end

    def series_title
      @title.sub(/（[0-9０-９\.．上中下]+）/, '').sub(/（完）/, '')
    end
  end

  class RakutenBookPublicationItemFactory
    # @params [Date] month
    def initialize(month:)
      @month = month
    end

    # @params [String] date_string m月d日
    # @params [String] title_with_number XXXXXXXXXXXX（１）
    # @params [String] author_name
    # @params [String] label
    def build(date_string:, title:, author_name:, label:)
      if date_string =~ /(\d+)月(\d+)日/
        date_min = date_max = Date.new(@month.year, $1.to_i, $2.to_i)
      elsif date_string =~ /(\d+)月(上旬|中旬|下旬)/
        case $2
        when '上旬'
          date_min = Date.new(@month.year, $1.to_i, 1)
          date_max = Date.new(@month.year, $1.to_i, 10)
        when '中旬'
          date_min = Date.new(@month.year, $1.to_i, 11)
          date_max = Date.new(@month.year, $1.to_i, 20)
        when '下旬'
          date_min = Date.new(@month.year, $1.to_i, 21)
          date_max = date_min.end_of_month
        end
      else
        fail
      end

      RakutenBookPublicationItem.new(
        date_min: date_min,
        date_max: date_max,
        title: title,
        author_name: author_name,
        label: label
      )
    end
  end

  def initialize(year:, month:)
    @month = Date.new(year, month, 1)
  end

  # @return [String] 指定された月のJSONデータを取得できるURL
  def json_uri
    index_uri = BASE_URI
    index_json_uri = "#{BASE_URI}/js/booklist.json"
    monthly_json_uri = "#{BASE_URI}/#{@month.year}/#{sprintf('%02d', @month.month)}/js/booklist.json"

    agent = Mechanize.new
    index_page = agent.get(index_uri)
    index_month_string = index_page.search('div.past-calendar dd').first.content

    if index_month_string =~ /^(\d+)年(\d+)月発売カレンダー$/
      booklist_last_month = Date.new($1.to_i, $2.to_i, 1)
    else
      fail
    end

    if @month == booklist_last_month
      index_json_uri
    else
      monthly_json_uri
    end
  end

  def update!
    fetch.each do |rakuten_book_publication_item|
      serial = Serial.find_or_create_by!(title: rakuten_book_publication_item.series_title)

      serial.publications.find_or_initialize_by(title: rakuten_book_publication_item.title) do |publication|
        publication.date_min = rakuten_book_publication_item.date_min
        publication.date_max = rakuten_book_publication_item.date_max
      end.save!
    end
  end

  def fetch
    response_body = open(json_uri, 'r:UTF-8').read

    # BOMを削除
    #
    # Kernel.#open では r:BOM|UTF-8 という記法によりBOMを除去できるが
    # open-uri ではこの記法が使えないため力技で除去する
    response_body_excluding_bom = response_body.sub(/^#{BOM_UTF_8}/, '')

    response_json = JSON.parse(response_body_excluding_bom)

    factory = RakutenBookPublicationItemFactory.new(month: @month)
    publication_items = []

    response_json['list'].each do |item|
      publication_items << factory.build(
        date_string: item[20],
        title: item[5],
        author_name: item[7],
        label: item[10]
      )
    end

    publication_items
  end
end
