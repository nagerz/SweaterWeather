class CitiesController < ApplicationController
  def show
  end

  def create
    @city = find_or_create_by(latitude: location.lat, longitude: location.long)
  end
end
