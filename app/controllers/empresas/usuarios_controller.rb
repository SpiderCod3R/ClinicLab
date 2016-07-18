class Empresas::UsuariosController < ApplicationController
  load_and_authorize_resource :empresa
  load_and_authorize_resource :usuario, through: :empresa
  before_action :authenticate_usuario!
  before_action :set_empresa, only: [:new, :create, :edit, :update]
  before_action :set_usuario, only: [:change_password, :change_user_password, :update_permissions, :update_modules, :destroy]
  # skip_authorize_resource only: [:update_permissions]

  def index
    @usuarios = Usuario.da_empresa_atual(empresa_atual["id"]).ordenado_pelo_nome
    respond_with(@usuarios)
  end

  def new
    respond_with(@usuario)
  end

  def show
    # => ACTION VIEW
  end

  def create
    @usuario.associado_com_a_empresa = @empresa
    if @usuario.save
      flash[:notice] = "Usuario criado com sucesso. Agora Selecione os módulos!"
      session[:usuario_id] = @usuario.id
      if @usuario.funcionario?
        redirect_to empresa_funcionarios_path(@empresa.id)
      else
        redirect_to empresas_empresa_path @usuario.empresa
      end
    else
      render :new
    end
  end

  def edit
    # => ACTION VIEW
  end

  def update
    if @usuario.update_resource(resource_params)
      redirect_to empresa_path(@usuario.empresa), notice: "Usuário Atualizado com sucesso."
    end
  end

  def destroy
    @usuario.destroy
    binding.pry
    redirect_to empresa_path current_usuario.empresa
  end

  def change_password
  end

  def trocar_senha
    respond_with @usuario, location: -> { change_user_password(@usuario) }
  end

  def change_user_password
    if @usuario.update_password(password_params)
      flash[:notice] = "Senha alterada com sucesso. A partir de agora o usuario #{@usuario.nome } deverá usar sua nova senha."
      redirect_to root_url
    else
      flash[:error] = "Cadastro não atualizado."
      render template: "empresas/usuarios/change_password"
    end
  end

  def update_permissions
    @usuario.usuario_permissao_empresas.build
  end

  protected

  def usuario_atual_super?
    @usuario_atual ||= current_usuario.super?
  end

  private

  def set_usuario
    @usuario = Usuario.retornar_objeto_pelo_id(params[:id])
  end

  def set_empresa
    @empresa = Empresa.retornar_objeto_pelo_id(params[:empresa_id]) if params[:empresa_id]
  end

  def password_params
    params.require(:usuario).permit(:current_password, :password, :password_confirmation)
  end

  def resource_params
    params.require(:usuario).permit(:username, :nome, :email, :password, :funcao_id, :empresa_id,
                  usuario_permissao_empresas_attributes: [:id, :usuario_id, :empresa_id, :cadastrar, :editar, :excluir, :visualizar],
                  :usuario_permissao_empresa_ids =>[],
                  :permissao_empresa_ids =>[])
  end
end
