class SerialsController < ApplicationController
  def index
    serials = SerialSearchQuery.new(params[:query]).relation

    render json: serials.to_json(only: [:id, :title])
  end
end
