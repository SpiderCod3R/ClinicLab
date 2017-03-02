class Painel::Usuarios::AccountsController < Support::InsideController
  before_action :find_environment
  before_action :find_usuario, only: [:show_permissions, :change_password ,:destroy]

  respond_to :html, :xml, :js, :json

  def index
    @empresa_usuarios = Gclinic::User.where(environment: current_user.environment).page params[:page]
  end

  def show_permissions
  end

  def edit
    @user = Gclinic::User.find(params[:id])
  end

  def new
    if user_signed_in?
      @empresa = Empresa.find(current_user.empresa) if current_user
      @usuario = Gclinic::User.new
    end
  end

  def change_account
    @user = Gclinic::User.find(params[:id])
    if user_params[:password]==""
      if @user.update_without_password(user_params)
        flash[:info] = "Usuário atualizado."
        redirect_to empresa_contas_path(current_user.empresa)
      else
        render :edit
      end
    elsif user_params[:password] != ""
      if @user.update(user_params)
        flash[:info] = "Usuário atualizado."
        redirect_to empresa_contas_path(current_user.empresa)
      else
        render :change_account
      end
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

    def password_params
      params.require(:gclinic_user).permit(:id, :password, :password_confirmation)
    end

    def user_params
      params.require(:gclinic_user).permit(:nome, :login, :email, :password, :password_confirmation,
                                             :admin, :telefone, :codigo_pais, :empresa_id)
    end
end
