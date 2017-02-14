class Painel::Usuarios::AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_environment
  before_action :find_usuario, only: [:show_permissions, :change_password ,:destroy]
  before_action :find_empresa, only: [:index]

  respond_to :html, :xml, :js, :json

  def index
    @empresa_usuarios = Gclinic::User.where(empresa_id: @empresa).page params[:page]
  end

  def show_permissions
  end

  def change_password
  end

  def new
    if user_signed_in?
      @empresa = Empresa.find(current_user.empresa) if current_user
      @usuario = Gclinic::User.new
    end
  end

  def destroy
    
  end

  private
    def set_environment
      @environment = Gclinic::Environment.friendly.find(current_user.environment)
      Thread.current[:environment_type]= @environment.database_name
      session[:environment_type]= @environment.database_name
    end

    def find_empresa
      @empresa = Empresa.friendly.find(params[:empresa_id])
    end

    def find_usuario
      @usuario = Gclinic::User.find(params[:id])
    end

    def password_params
      params.require(:painel_usuario).permit(:id, :password, :password_confirmation)
    end

    def usuario_params
      params.require(:painel_usuario).permit(:nome, :login, :email, :password, :password_confirmation,
                                             :admin, :telefone, :codigo_pais, :empresa_id)
    end
end
