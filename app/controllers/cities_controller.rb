class CitiesController < ApplicationController
  def show
    if params[:location] && params[:location] != ""
      render locals: {
        facade: ForecastFacade.new(params[:location]).forecast
      }
    else
      render locals: {
        facade: nil
      }
    end
  end

  def create
    if params[:location] == ""
      flash[:alert] = 'Please enter a search location'
      redirect_to root_path

    else
      redirect_to root_path(location: params[:location])
    end
  end

end
