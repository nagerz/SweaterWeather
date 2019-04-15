class Api::V1::BackgroundsController < ApplicationController
  def index
    render json: BackgroundSerializer.new(Background.new(params[:location]))
  end
end
