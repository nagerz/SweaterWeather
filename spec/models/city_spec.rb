require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:long) }
    it { should validate_presence_of(:query) }
  end

  describe 'relationships' do
    it { should have_many(:favorites) }
    it { should have_many(:users).through(:favorites) }
  end

  describe 'Class Methods' do
  end

  describe 'Instance Methods' do
  end
end
