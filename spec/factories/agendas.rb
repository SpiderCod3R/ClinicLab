FactoryGirl.define do
  # agenda_manha_horario factory with a `belongs_to` association for the agenda
  factory :agenda_manha_horario do
    dia nil
    turno {"Manha"}
    inicio_do_atendimento {Faker::Time.forward(23, :all)}
    final_do_atendimento  {Faker::Time.forward(23, :all)}
    agenda
  end

  # agenda_tarde_horario factory with a `belongs_to` association for the agenda
  factory :agenda_tarde_horario do
    dia nil
    turno {"Tarde"}
    inicio_do_atendimento {Faker::Time.forward(23, :all)}
    final_do_atendimento  {Faker::Time.forward(23, :all)}
    agenda
  end

  factory :agenda do
    data_inicial { "01/08/2016" }
    data_final   { "26/08/2016" }
    atendimento_duracao { "30" }
    association :profissional, factory: [:profissional, :pediatra], strategy: :build
    association :empresa, factory: :empresa, strategy: :build
    association :usuario, factory: :usuario, strategy: :build

    trait :atendimento_normal do
      atendimento_sabado   false
      atendimento_domingo  false
    end

    trait :atendimento_sabado do
      atendimento_sabado  true
      atendimento_domingo  false
    end

    trait :atendimento_domingo do
      atendimento_sabado  false
      atendimento_domingo  true
    end

    trait :atendimento_fim_de_semana do
      atendimento_sabado   true
      atendimento_domingo  true
    end

    trait :horario_completo do
      horario_parcial  false
    end

    trait :horario_parcial do
      horario_parcial  true
    end

    # => A Agenda deve poder inserir horarios de acordo com as opções booleanas

    factory :agenda_manha_sem_fim_de_semana, traits: [:atendimento_normal, :horario_completo] do
      transient do
        agenda_manha_horario_count 5
      end

      after(:create) do |agenda, evaluator|
        create_list(:agenda_manha_horario, evaluator.agenda_manha_horario_count, agenda: agenda)
      end
    end

    factory :agenda_vespertina_sem_fim_de_semana, traits: [:atendimento_normal, :horario_completo] do
      transient do
        agenda_vespertina_horario_count 5
      end

      after(:create) do |agenda, evaluator|
        create_list(:agenda_tarde_horario, evaluator.agenda_vespertina_horario_count, agenda: agenda)
      end
    end
  end
end