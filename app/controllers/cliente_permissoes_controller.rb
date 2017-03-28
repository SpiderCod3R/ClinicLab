class ClientePermissoesController < Support::InsideController
  def manager
    @user       = Gclinic::User.find(params[:id])
    @model      = Gclinic::Model.find_by(model_class: "Cliente")
    @user_model = @user.user_models.find_by(model_id: @model.id)
    @cliente_permissao = ClientePermissao.find_by user_model_id: @user_model.id
    @cliente_permissao = ClientePermissao.new if @cliente_permissao.nil?
  end

  def build_permissions
    @user_model = Gclinic::UserModel.find(resource_params[:user_model_id])
    @cliente_permissao  = ClientePermissao.find_by(user_model_id: resource_params[:user_model_id])

    if !@cliente_permissao.nil?
      @cliente_permissao  = ClientePermissao.update_content(resource_params)
    else
      @cliente_permissao  = ClientePermissao.create(resource_params)
    end

    flash[:notice] = "Permissões da Agenda adicionadas"
    redirect_to manager_empresa_cliente_permissao_path(@user_model.user.empresa, @user_model.user)
  end

  private
    def resource_params
      params.require(:cliente_permissao).permit(:usuario_permissoes_id, :user_model_id, :historico, :texto_livre, :pdf_upload, :receituario, :imagens_externas)
    end
end