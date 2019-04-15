class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  set_id :location
  attributes :urls
end
