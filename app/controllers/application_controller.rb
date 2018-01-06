class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_current_user

  attr_reader :current_user

  def set_current_user
    @current_user = User.find_by_id(session[:user_id])
  end

  def logged_in?
    session[:user_id].present?
  end
end
