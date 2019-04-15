require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:long) }
  end

  describe 'relationships' do
  end

  describe 'Class Methods' do
  end

  describe 'Instance Methods' do
  end
end
