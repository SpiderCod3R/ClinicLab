class ClientePermissoesController < ApplicationController
  before_action :authenticate_usuario!

  def manager
    @usuario = Painel::Usuario.find(params[:id])
    @permissao = Painel::Permissao.find_by(model_class: "Cliente")
    @usuario_permissao = @usuario.usuario_permissoes.find_by(permissao_id: @permissao.id)
    @cliente_permissao = ClientePermissao.find_by usuario_permissoes_id: @usuario_permissao.id
    @cliente_permissao = ClientePermissao.new if @cliente_permissao.nil?
  end

  def build_permissions
    @usuario_permissao = Painel::UsuarioPermissao.find(resource_params[:usuario_permissoes_id])
    @cliente_permissao  = ClientePermissao.find_by(usuario_permissoes_id: resource_params[:usuario_permissoes_id])

    if !@cliente_permissao.nil?
      @cliente_permissao  = ClientePermissao.update_content(resource_params)
    else
      @cliente_permissao  = ClientePermissao.create(resource_params)
    end

    flash[:notice] = "Permissões do Cliente adicionadas"
    redirect_to manager_cliente_permissao_path(@usuario_permissao.usuario.id)
  end

  private
    def resource_params
      params.require(:cliente_permissao).permit(:usuario_permissoes_id, :historico, :texto_livre, :pdf_upload)
    end
end
