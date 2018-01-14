class PublicationPersistenceService
  def initialize(publication_item)
    @publication_item = publication_item
  end

  def save!
    serial = Serial.find_or_create_by!(title: @publication_item.series_title)

    publication = serial.publications.find_or_initialize_by(title: @publication_item.title)
    publication.date_min = @publication_item.date_min
    publication.date_max = @publication_item.date_max

    if publication.new_record?
      if publication.save!
        AmazonItemAttributeUpdaterJob.perform_later(publication)
      else
        fail
      end

      true
    else
      publication.save!
    end
  end
end
