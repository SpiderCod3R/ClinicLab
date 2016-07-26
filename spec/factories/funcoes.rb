FactoryGirl.define do
  factory :funcao do
    nome { "Administrador" }
    descricao { Faker::Hipster.paragraph(2, true) }
  end
end