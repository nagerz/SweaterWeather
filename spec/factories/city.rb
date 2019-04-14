FactoryBot.define do
  factory :city do
    city { Faker::Address.city }
    state { Faker::Address.state }
  end
end
