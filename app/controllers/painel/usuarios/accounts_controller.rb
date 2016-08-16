class Painel::Usuarios::AccountsController < ApplicationController
  before_action :authenticate_usuario!, only: [:index]
  before_action :find_usuario, only: [:show_permissions, :change_password ,:destroy]
  before_action :find_empresa, only: [:index]

  respond_to :html, :xml, :js, :json

  def index
    @empresa_usuarios = Painel::Usuario.where(empresa_id: @empresa).page params[:page]
  end

  def show_permissions
  end

  def change_password
  end

  def new
    if master_signed_in? || usuario_signed_in?
      @empresa = Painel::Empresa.find(current_usuario.empresa_id) if current_usuario
      @usuario = Painel::Usuario.new
    end
  end

  def destroy
    
  end

  private
    def find_empresa
      @empresa = Painel::Empresa.friendly.find(params[:empresa_id])
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
