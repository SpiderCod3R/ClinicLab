class Painel::Usuarios::AccountsController < Support::InsideController
  before_action :find_environment
  before_action :find_usuario, only: [:show_permissions, :change_password ,:destroy]

  respond_to :html, :xml, :js, :json

  def index
    @empresa_usuarios = Gclinic::User.where(environment: current_user.environment).page params[:page]
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
    def find_environment
      @environment = Gclinic::Environment.friendly.find(current_user.environment)
    end

    def find_usuario
      @user = Gclinic::User.find(params[:id])
    end
end
