FactoryGirl.define do
  factory :profissional do
    status { 1 }
    nome { Faker::Name.name }
    endereco { Faker::Address.street_address }
    complemento { Faker::Address.secondary_address }
    bairro { "Blue Deep Lake" }
    rg { "41.253.119-7" }
    cpf { "268.808.764-98" }
    telefone { Faker::PhoneNumber.phone_number }
    celular { Faker::PhoneNumber.cell_phone }
    data_nascimento { Faker::Date.between_except(20.year.ago, 1.year.from_now, Date.today) }
    association :cargo, factory: :cargo
    association :conselho_regional, factory: :conselho_regional
    association :estado, factory: :estado
    association :cidade, factory: :cidade
    association :operadora, factory: :operadora
    association :empresa, factory: :empresa
  end
end