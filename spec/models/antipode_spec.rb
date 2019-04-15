require 'rails_helper'

RSpec.describe Antipode do
  it 'has location' do
    antipode = Antipode.new('hongkong')

    expect(antipode.location).to eq("hongkong")
  end

  it 'has search location' do
    antipode = Antipode.new('hongkong')

    expect(antipode.search_location).to eq("Hong Kong")
  end
end
