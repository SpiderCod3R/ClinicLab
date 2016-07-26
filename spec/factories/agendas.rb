FactoryGirl.define do
  factory :agenda do
    data_inicial { "01/08/2016" }
    data_final   { "26/08/2016" }
    atendimento_duracao { "30"}
    association :profissional, factory: :profissional
    association :empresa, factory: :empresa
    association :usuario, factory: :usuario

    trait :horario_completo do
      horario_parcial  false 
    end

    trait :horario_parcial do
      horario_parcial  true 
    end

    trait :atendimento_normal do
      atendimento_sabado   false 
      atendimento_domingo  false 
    end

    trait :atendimento_sabado do
      atendimento_sabado  true 
    end

    trait :atendimento_domingo do
      atendimento_domingo  true 
    end

    trait :atendimento_fim_de_semana do
      atendimento_sabado   true 
      atendimento_domingo  true 
    end


    # => Agenda Normal
    factory :agenda_parcial_sem_fim_de_semana, traits: [:horario_atendimento_parcial, :atendimento_normal]
    factory :agenda_completo_sem_fim_de_semana, traits: [:horario_atendimento_completo, :atendimento_normal]

    # => Atendimentos Completos com final de semana
    factory :agenda_completo_com_fim_de_semana, traits: [:horario_atendimento_completo, :atendimento_fim_de_semana]
    factory :agenda_completo_com_sabado, traits: [:horario_atendimento_completo, :atendimento_sabado]
    factory :agenda_completo_com_domingo, traits: [:horario_atendimento_completo, :atendimento_domingo]

    # => Atendimentos Parciais com final de semana
    factory :agenda_parcial_com_fim_de_semana, traits: [:horario_atendimento_parcial, :atendimento_fim_de_semana]
    factory :agenda_parcial_com_sabado, traits: [:horario_atendimento_parcial, :atendimento_sabado]
    factory :agenda_parcial_com_domingo, traits: [:horario_atendimento_parcial, :atendimento_domingo]
  end
end