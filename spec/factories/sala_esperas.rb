FactoryGirl.define do
  factory :sala_espera do
    cliente nil
    data "2017-03-03"
    referencia_agenda nil
    status "MyString"
    hora_agendada "MyString"
    hora_chegada "MyString"
    hora_inicio_atendimento "MyString"
    hora_fim_atendimento "MyString"
  end
end
