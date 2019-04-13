class City < ApplicationRecord
  validates :city, uniqueness: true, presence: true
  validates :state, uniqueness: true, presence: true
end
