class Painel::AgendaPermissoesController < ApplicationController
  before_action :authenticate_usuario!
  # before_action :find_empresa
  # before_action :find_agenda

  def manager
    @usuario = Painel::Usuario.find(params[:id])
    @permissao = Painel::Permissao.find_by(model_class: "Agenda")
    @usuario_permissao = @usuario.usuario_permissoes.find_by(permissao_id: @permissao.id)
    @agenda_permissao = AgendaPermissao.find_by usuario_permissoes_id: @usuario_permissao.id

    @agenda_permissao = AgendaPermissao.new if @agenda_permissao.nil?
  end

  def build_agenda_permissions
    @usuario_permissao = Painel::UsuarioPermissao.find(resource_params[:usuario_permissoes_id])
    @agenda_permissao  = AgendaPermissao.find_by(usuario_permissoes_id: resource_params[:usuario_permissoes_id])
    if !@agenda_permissao.nil?
      @agenda_permissao  = AgendaPermissao.update_content(resource_params)
    else
      @agenda_permissao  = AgendaPermissao.create(resource_params)
    end

    flash[:notice] = "Permissões da Agenda adicionadas"
    redirect_to manager_agenda_permissao_path(@usuario_permissao.usuario.id)
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