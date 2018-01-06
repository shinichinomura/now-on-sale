class DefaultController < ApplicationController
  def index
    if current_user.present?
      @subscriptions = current_user.subscriptions.includes(:serial)
    end
  end
end
