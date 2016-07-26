FactoryGirl.define do
  factory :estado do
    nome { Faker::Address.state }
    # association :capital, factory: :cidade
  end
end