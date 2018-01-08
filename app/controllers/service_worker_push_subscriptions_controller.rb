class ServiceWorkerPushSubscriptionsController < ApplicationController
  protect_from_forgery except: [:create]

  def create
    begin
      ServiceWorkerPushSubscription.find_or_initialize_by(
        user_id: current_user.id,
        registration_id: params[:registration_id]
      ).save!

      render json: { result: 'success' }
    rescue
      render json: { result: 'error' }
    end
  end
end
