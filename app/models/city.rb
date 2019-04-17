class City < ApplicationRecord
  validates :city, presence: true
  validates :lat, presence: true
  validates :long, presence: true
  validates :query, presence: true

  has_many :favorites
  has_many :users, through: :favorites
end
