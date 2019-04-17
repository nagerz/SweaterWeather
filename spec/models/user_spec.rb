require 'rails_helper'
describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many(:favorites) }
    it { should have_many(:cities).through(:favorites) }
  end
end
