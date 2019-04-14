class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attribute :current_temperature do |object|
    binding.pry
  end
end
