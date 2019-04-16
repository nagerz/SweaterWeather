class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true

  has_many :favorites
  has_many :cities, through: :favorites

  has_secure_password
end
