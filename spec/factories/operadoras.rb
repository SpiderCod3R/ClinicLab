FactoryGirl.define do
  factory :operadora do
    nome { "VIVO" }
    status { "ON" }
    association :empresa, factory: :empresa
  end
end
