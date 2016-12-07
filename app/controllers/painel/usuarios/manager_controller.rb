class Painel::Usuarios::ManagerController < ApplicationController
  before_action :find_empresa, except: [:create, :update_password, :add_permissions, :save_permissions]

  respond_to :html, :js, :xml, :json

  def update
    if master_signed_in? || usuario_signed_in?
      @usuario = Painel::Usuario.find(params[:id])
      @usuario.update_without_password(usuario_params)
    end
    respond_to &:js
  end

  def update_password
    if master_signed_in? || usuario_signed_in?
      @usuario = Painel::Usuario.find(password_params[:id])
      @usuario.update_with_password(password_params)
    end
    respond_to &:js
  end

  def add_permissions
    @usuario = Painel::Usuario.find(params[:painel_usuario_id])
    @empresa_permissoes = @usuario.verify_permissions_not_added
  end

  def save_permissions
    if params[:usuario]
      @usuario = Painel::Usuario.find(params[:usuario]["0"]["usuario_id"])
    end
    if params[:usuario_permissoes]
      @usuario.import_permissoes(params[:usuario_permissoes])
    end
    # binding.pry

    if @usuario.save(validate: false)
      respond_to &:json
    end
  end

  def destroy
    
  end


  private
    def find_empresa
      @empresa = Painel::Empresa.friendly.find(params[:empresa_id])
    end

    def password_params
      params.require(:painel_usuario).permit(:id, :password, :password_confirmation)
    end

    def usuario_params
      params.require(:painel_usuario).permit(:nome, :login, :email, :password, :password_confirmation,
                                             :admin, :telefone, :codigo_pais, :empresa_id)
    end
end
