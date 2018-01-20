class RecentPublicationQuery
  def relation
    Publication.where('date_min <= ? and date_max >= ?', 3.days.since, 3.days.ago).order(:date_min)
  end
end
