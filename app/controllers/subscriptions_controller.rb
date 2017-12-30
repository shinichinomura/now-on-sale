class SubscriptionsController < ApplicationController
  def index
    return_hash = {}

    current_user.subscriptions.each do |subscription|
      return_hash[subscription.serial_id] = true
    end

    render json: return_hash.to_json
  end

  def create
    current_user.subscriptions.create!(serial_id: params[:serial_id])

    render json: { result: 'success' }
  end

  def delete
    current_user.subscriptions.find_by_serial_id(params[:serial_id]).destroy

    render json: { result: 'success' }
  end
end
