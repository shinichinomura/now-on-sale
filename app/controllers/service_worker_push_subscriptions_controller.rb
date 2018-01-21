class ServiceWorkerPushSubscriptionsController < ApplicationController
  protect_from_forgery except: [:create]

  def create
    begin
      ServiceWorkerPushSubscriptionCreationService.create!(
        user_id: current_user.id,
        registration_id: params[:registration_id],
        request: request
      )

      render json: { result: 'success' }
    rescue => e
      Rollbar.error(e)

      render json: { result: 'error' }
    end
  end
end
