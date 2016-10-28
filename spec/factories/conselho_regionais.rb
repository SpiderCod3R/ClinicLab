FactoryGirl.define do
  factory :conselho_regional do
    sigla { Faker::Address.state_abbr }
    descricao { Faker::Hipster.paragraph(2, true) }
    status { 1 }
  end
end