FactoryGirl.define do
  factory :empresa do
    nome { Faker::Space.company }
  end
end