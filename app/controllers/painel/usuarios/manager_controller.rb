class Painel::Usuarios::ManagerController < ApplicationController
  before_action :find_empresa, except: [:create, :update_password]

  respond_to :html, :js, :xml, :json

  def create
    if params[:usuario]
      @usuario = Painel::Usuario.new_by(params[:usuario]["0"])
      @usuario.empresa_id = current_usuario.empresa_id
    end

    if params[:usuario_permissoes]
      @usuario.import_permissoes(params[:usuario_permissoes])
    end

    if @usuario.save
      respond_to &:json
    end
  end

  def update
    if master_signed_in? || usuario_signed_in?
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

  private
    def find_empresa
      @empresa = Painel::Empresa.find(params[:empresa_id])
    end

    def find_usuario
      @usuario = Painel::Usuario.find(params[:id])
    end

    def password_params
      params.require(:painel_usuario).permit(:id, :password, :password_confirmation)
    end

    def usuario_params
      params.require(:painel_usuario).permit(:nome, :login, :email, :password, :password_confirmation,
                                             :admin, :telefone, :codigo_pais, :empresa_id)
    end
end
