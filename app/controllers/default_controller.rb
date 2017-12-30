class DefaultController < ApplicationController
  def index
    @subscriptions = current_user.subscriptions.includes(:serial)
  end
end
