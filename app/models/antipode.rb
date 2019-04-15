class Antipode
  attr_reader :location, :search_location

  def initialize(location)
    @location = location
  end

  def search_location
    @location.capitalize
  end

end
