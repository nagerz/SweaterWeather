class Api::V1::AntipodeController < ApplicationController

  def show
    render json: AntipodeSerializer.new([Antipode.new(params[:loc])])
  end

end
