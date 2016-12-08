class Painel::AgendaPermissoesController < ApplicationController
  before_action :authenticate_usuario!
  # before_action :find_empresa
  # before_action :find_agenda

  def manager
    @usuario = Painel::Usuario.find(params[:id])
    @agenda_permissao = Painel::Permissao.find_by(model_class: "Agenda")
    @usuario_permissao = @usuario.usuario_permissoes.find_by(permissao_id: @agenda_permissao.id)
    @agenda_permissao = AgendaPermissao.find_by usuario_permissoes_id: @usuario_permissao.id

    @agenda_permissao = AgendaPermissao.new if @agenda_permissao.nil?
    # binding.pry
  end

  def build_agenda_permissions
    @agenda_permissao = AgendaPermissao.find_or_create_by(resource_params)
    
    binding.pry
  end

  private
    def resource_params
      params.require(:agenda_permissao).permit(:usuario_permissoes_id, :agendar, :excluir,
                                               :trocar_horario, :realizar_atendimento,
                                               :visualizar_atendimento, :limpar_horario,
                                               :paciente_nao_veio, :remarcar_pelo_paciente,
                                               :remarcar_pelo_medico, :desmarcar_pelo_paciente,
                                               :desmarcar_pelo_medico)
    end
end