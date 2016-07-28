FactoryGirl.define do
  factory :estado do
    nome { Faker::Address.state }
    capital
  end
end