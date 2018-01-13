class SerialsController < ApplicationController
  def index
    serials = SerialSearchQuery.new(params[:query]).relation

    render json: serials.to_json(only: [:id, :title])
  end

  def show
    @serial = Serial.find(params[:id])
    @publications = @serial.publications.order(date_min: :desc)
  end
end
