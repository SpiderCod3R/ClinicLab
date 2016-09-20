FactoryGirl.define do
  factory :agenda_horario do
    association :agenda, factory: :agenda, strategy: :build
    dia_da_semana {"Segunda-Feira"}
    turno {"Manha"}
    hora "09:55:59"
    tipo_atendimento false
  end
end
