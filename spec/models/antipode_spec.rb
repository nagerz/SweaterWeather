require 'rails_helper'

RSpec.describe Antipode do
  it 'has location' do
    antipode = Antipode.new('hongkong')

    expect(antipode.location).to eq("hongkong")
  end

  it 'has location' do
    antipode = Antipode.new('hongkong')

    expect(antipode.location).to eq("hongkong")
  end
end
