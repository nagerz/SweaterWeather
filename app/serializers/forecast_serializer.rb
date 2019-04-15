class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :latitude, :longitude, :time, :city, :state

  attribute :current_weather do |object|
    object.currently
  end

  attribute :details do |object|
    object.details
  end

  attribute :forecast do |object|
    object.forecast
  end
end
