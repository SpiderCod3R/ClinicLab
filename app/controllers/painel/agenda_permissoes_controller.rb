class Painel::AgendaPermissoesController < Support::InsideController
  def manager
    @user       = Gclinic::User.find(params[:id])
    @model      = Gclinic::Model.find_by(model_class: "Agenda")
    @user_model = @user.user_models.find_by(model_id: @model.id)
    @agenda_permissao = AgendaPermissao.find_by user_model_id: @user_model.id
    @agenda_permissao = AgendaPermissao.new if @agenda_permissao.nil?
  end

  def build_agenda_permissions
    @user_model = Gclinic::UserModel.find(resource_params[:user_model_id])
    @agenda_permissao  = AgendaPermissao.find_by(user_model_id: resource_params[:user_model_id])

    if !@agenda_permissao.nil?
      @agenda_permissao  = AgendaPermissao.update_content(resource_params)
    else
      @agenda_permissao  = AgendaPermissao.create(resource_params)
    end

    flash[:notice] = "Permissões da Agenda adicionadas"
    redirect_to manager_empresa_agenda_permissao_path(@user_model.user.empresa, @user_model.user)
  end

  private
    def resource_params
      params.require(:agenda_permissao).permit(:user_model_id, :agendar, :excluir,
                                               :trocar_horario, :realizar_atendimento,
                                               :visualizar_atendimento, :limpar_horario,
                                               :paciente_nao_veio, :remarcar_pelo_paciente,
                                               :remarcar_pelo_medico, :desmarcar_pelo_paciente,
                                               :desmarcar_pelo_medico, :movimento_servico)
    end
end