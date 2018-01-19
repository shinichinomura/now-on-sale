class SerialsController < ApplicationController
  def index
    serials = SerialSearchQuery.new(params[:query]).relation

    render json: serials.to_json(only: [:id, :title])
  end

  def show
    @serial = Serial.find(params[:id])
    @publications = @serial.publications.order(date_min: :desc)

    @next_publication = PublicationForecaster.new(@publications.map(&:date_min)).predict

    @page_title = "「#{@serial.title}」の発売日一覧"
  end
end
