module ApplicationHelper
  def page_title(page_title = nil)
    site_description = "マンガの新刊発売情報をTwitterやプッシュ通知でお知らせ"

    if page_title
      "#{page_title} - #{site_description}"
    else
      "#{site_description} - NowOnSale"
    end
  end

  def logged_in?
    @current_user.present?
  end
end
