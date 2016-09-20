FactoryGirl.define do
  factory :cargo do
    association :empresa, factory: :empresa
    nome { Faker::Space.company }
    status { 1 }
  end
end