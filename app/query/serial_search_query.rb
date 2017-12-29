class SerialSearchQuery
  def initialize(query)
    @query = query
  end

  def relation
    Serial.where('title like ?', "%#{@query}%")
  end
end
