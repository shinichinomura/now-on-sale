class PublicationForecaster
  def initialize(date_list)
    @date_list = date_list
  end

  # @return [Date]
  def predict
    return false unless predictable?

    sorted_date_list = @date_list.sort.reverse

    sorted_date_list.first + (sorted_date_list.first - sorted_date_list.second)
  end

  def predictable?
    @date_list.count >= 2
  end
end
