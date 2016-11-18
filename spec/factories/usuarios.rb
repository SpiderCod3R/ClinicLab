FactoryGirl.define do
  factory :usuario do
    nome      { Faker::StarWars.character }
    username  { Faker::Superhero.name }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password(8) }
    association :funcao, factory: :funcao
    association :empresa, factory: :empresa
  end
end