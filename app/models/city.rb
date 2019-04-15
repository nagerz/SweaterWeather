class City < ApplicationRecord
  validates :city, presence: true
  validates :lat, presence: true
  validates :long, presence: true
  validates :query, presence: true
end
