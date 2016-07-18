class Empresas::EmpresasController < ApplicationController
  load_and_authorize_resource param_method: :resource_params
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]

  def index
    @empresas = Empresa.all
  end

  def show
    if current_usuario.super?
      @empresa_usuarios = @empresa.usuarios.administradores
      respond_with(@empresa_usuarios)
    end
  end

  def new
    @empresa = Empresa.new
    @empresa.usuarios.build
    @empresa.permissao_empresas.build.empresa_permissao_empresas
    respond_with(@empresa)
  end

  def edit
  end

  def create
    @empresa = Empresa.new(resource_params)
    if @empresa.save
      flash[:notice] = t("flash.actions.#{__method__}.notice", resource_name: @empresa.nome)
      respond_with(@empresa)
    else
      render :new
    end
  end

  def update
    if @empresa.update(resource_params)
      flash[:notice] = t("flash.actions.#{__method__}.notice", resource_name: @empresa.nome)
      respond_with(@empresa)
    end
  end

  def destroy
    if @empresa.destroy
      flash[:notice] = t("flash.actions.#{__method__}.notice", resource_name: @empresa.nome)
    else
      flash[:notice] = t("flash.actions.#{__method__}.alert", resource_name: @empresa.nome)
    end
    respond_with nil, location: empresas_path
  end

  private
    def set_empresa
      @empresa = Empresa.find(params[:id])
    end

    def resource_params
      params.require(:empresa).permit(:nome,
                                      usuarios_attributes: [:username, :nome, :email, :password, :funcao_id],
                                      :permissao_empresa_ids =>[])
    end
end
