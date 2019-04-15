class AntipodeSerializer
  include FastJsonapi::ObjectSerializer
  set_id 1
  attributes :location_name, :forecast, :search_location

  
end
