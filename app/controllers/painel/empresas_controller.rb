class Painel::EmpresasController < ApplicationController
  layout 'admin'
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @empresas = Painel::Empresa.em_ordem_alfabetica.page params[:page]
    respond_with(@empresas)
  end

  def show
    @usuario = Painel::Usuario.new
    @administradores = @empresa.administradores.page params[:administradores_pagina]
    @funcionarios    = @empresa.funcionarios.page params[:funcionarios_pagina]
    @empresa_permissoes = @empresa.empresa_permissoes.page params[:permissoes]
    @empresa_permissao = @empresa.empresa_permissoes.build
    respond_with(@empresa)
  end

  def new
    @empresa = Painel::Empresa.new
    @empresa.usuarios.build
    respond_with(@empresa)
  end

  def edit
  end

  def create
    @empresa = Painel::Empresa.new(empresa_params)
    if @empresa.save
      redirect_to painel_empresa_path(@empresa)
      flash[:success] = "A empresa foi criada com sucesso."
    else
      flash[:error] = "A empresa não pode ser criada."
      render :new
    end
  end

  def update
    @empresa.update(empresa_params)
    respond_to &:js
  end

  def destroy
    @empresa.destroy
    respond_with(@empresa)
  end

  private
    def set_empresa
      @empresa = Painel::Empresa.find(params[:id])
    end

    def empresa_params
      params.require(:painel_empresa).permit(:nome, :status,
                                      usuarios_attributes: [:nome,
                                                            :login,
                                                            :email,
                                                            :password,
                                                            :password_confirmation,
                                                            :admin,
                                                            :telefone,
                                                            :codigo_pais,
                                                            :_destroy])
    end
end
