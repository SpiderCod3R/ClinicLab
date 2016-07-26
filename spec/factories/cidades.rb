FactoryGirl.define do
  factory :cidade, aliases: [:capital] do
    nome { Faker::Address.city }
    # association :estado, factory: :estado, strategy: :build
  end
end