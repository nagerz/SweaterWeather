class CitiesController < ApplicationController
  def show
  end

  def create
    if params[:location] == ""
      flash[:alert] = 'Please enter a search location'
      render :show
    else
      search_location = params[:location]
      parse_search(search_location)

      @city = find_or_create_by(latitude: location.lat, longitude: location.long)
    end
  end

  private

  def geocode_search(serch_location)
    
  end
end
