class City < ApplicationRecord
  validates :city, uniqueness: true, presence: true
  validates :state, uniqueness: true, presence: true
  validates :lat, presence: true
  validates :long, presence: true
end
