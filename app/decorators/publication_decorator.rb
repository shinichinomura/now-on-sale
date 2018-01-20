class PublicationDecorator < Draper::Decorator
  delegate_all

  def date
    if object.date_min == object.date_max
      date_min.strftime("%-m月%-d日")
    else
      if date_min <= 10
        date_min.strftime("%-m月上旬")
      elsif date_min <= 20
        date_min.strftime("%-m月中旬")
      else
        date_min.strftime("%-m月下旬")
      end
    end
  end
end
