FactoryGirl.define do
  factory :agenda_permissao do
    agenda nil
    usuario nil
    empresa nil
    agendar false
    excluir false
    trocar_horario false
    realizar_atendimento false
    visualizar_atendimento false
    limpar_horario false
    paciente_nao_veio false
    remarcar_pelo_paciente false
    remarcar_pelo_medico false
    desmarcar_pelo_medico false
    desmarcar_pelo_paciente false
  end
end
