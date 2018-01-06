class SessionsController < ApplicationController
  def destroy
    session[:user_id] = nil

    flash[:notice] = "ログアウトしました。"

    redirect_to :root
  end
end
