class SubscriptionsController < ApplicationController
  def index
    return_hash = {}

    current_user.subscriptions.each do |subscription|
      return_hash[subscription.serial_id] = true
    end

    render json: return_hash.to_json
  end

  def create
    Subscription.transaction do
      current_user.subscriptions.create!(serial_id: params[:serial_id])
      SubscriptionHistory.create!(
        user_id: current_user.id,
        serial_id: params[:serial_id],
        action: 'create'
      )
    end

    render json: { result: 'success' }
  end

  def delete
    Subscription.transaction do
      current_user.subscriptions.find_by_serial_id(params[:serial_id]).destroy
      SubscriptionHistory.create!(
        user_id: current_user.id,
        serial_id: params[:serial_id],
        action: 'delete'
      )
    end

    render json: { result: 'success' }
  end
end
