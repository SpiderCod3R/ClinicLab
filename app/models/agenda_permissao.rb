class AgendaPermissao < Connection::Factory
  include ActiveMethods

  belongs_to :agenda
  belongs_to :user_model, class_name: 'Gclinic::UserModel'
  belongs_to :empresa

  class << self
    def update_content(resource_params)
      update(user_model_id: resource_params[:user_model_id],
             agendar: resource_params[:agendar],
             excluir: resource_params[:excluir],
             trocar_horario: resource_params[:trocar_horario],
             realizar_atendimento: resource_params[:realizar_atendimento],
             visualizar_atendimento: resource_params[:visualizar_atendimento],
             limpar_horario: resource_params[:limpar_horario],
             paciente_nao_veio: resource_params[:paciente_nao_veio],
             remarcar_pelo_paciente: resource_params[:remarcar_pelo_paciente],
             remarcar_pelo_medico: resource_params[:remarcar_pelo_medico],
             desmarcar_pelo_paciente: resource_params[:desmarcar_pelo_paciente],
             desmarcar_pelo_medico: resource_params[:desmarcar_pelo_medico],
             movimento_servico: resource_params[:movimento_servico])
    end
  end
end
