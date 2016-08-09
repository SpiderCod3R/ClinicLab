class Painel::Usuarios::ManagerController < ApplicationController
  before_action :find_empresa, except: [:update_password]
  before_action :find_usuario, except: [:new, :create]

  respond_to :html, :js, :xml, :json

  def new
    #TODO
  end

  def create
    #TODO
  end

  def edit
    #TODO
  end

  def update
    binding.pry
    if master_signed_in? || usuario_signed_in?
      @usuario.update_without_password(usuario_params)
    end
    respond_to &:js
  end

  def update_password
    # binding.pry
    if master_signed_in? || usuario_signed_in?
      if @usuario.update_with_password(password_params)
        flash[:notice] = "Senha atualizada com sucesso"
      else
        flash[:error] = "Senha não pode ser atualizada"
      end
    end
    respond_to &:js
  end

  def destroy
    #TODO
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
                                             :admin, :telefone, :codigo_pais)
    end
end
