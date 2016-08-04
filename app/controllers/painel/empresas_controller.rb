class Painel::EmpresasController < ApplicationController
  before_action :set_painel_empresa, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @painel_empresas = Painel::Empresa.all
    respond_with(@painel_empresas)
  end

  def show
    respond_with(@painel_empresa)
  end

  def new
    @painel_empresa = Painel::Empresa.new
    respond_with(@painel_empresa)
  end

  def edit
  end

  def create
    @painel_empresa = Painel::Empresa.new(painel_empresa_params)
    @painel_empresa.save
    respond_with(@painel_empresa)
  end

  def update
    @painel_empresa.update(painel_empresa_params)
    respond_with(@painel_empresa)
  end

  def destroy
    @painel_empresa.destroy
    respond_with(@painel_empresa)
  end

  private
    def set_painel_empresa
      @painel_empresa = Painel::Empresa.find(params[:id])
    end

    def painel_empresa_params
      params.require(:painel_empresa).permit(:nome, :status)
    end
end
