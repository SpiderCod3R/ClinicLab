class CentroDeCustosController < ApplicationController
  load_and_authorize_resource param_method: :resource_params
  before_action :set_centro_de_custo, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @centro_de_custos = CentroDeCusto.da_empresa_atual(empresa_atual["id"])
    respond_with(@centro_de_custos)
  end

  def show
    respond_with(@centro_de_custo)
  end

  def new
    @centro_de_custo = current_usuario.empresa.centro_de_custos.build
    respond_with(@centro_de_custo)
  end

  def edit
  end

  def create
    @centro_de_custo = current_usuario.empresa.centro_de_custos.build(resource_params)
    if @centro_de_custo.save
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @centro_de_custo.class)
      redirect_to new_centro_de_custo_path
    else
      render :new
    end
  end

  def update
    if @centro_de_custo.update(resource_params)
      redirect_to centro_de_custos_path, notice: t("flash.actions.#{__method__}.notice", resource_name: @centro_de_custo.class)
    else
      render :edit
    end
  end

  def destroy
    if @centro_de_custo.destroy
      redirect_to centro_de_custos_path, notice: t("flash.actions.#{__method__}.notice", resource_name: @centro_de_custo.class)
    end
  end

  private
    def set_centro_de_custo
      @centro_de_custo = CentroDeCusto.find(params[:id])
    end

    def resource_params
      params.require(:centro_de_custo).permit(:nome, :status, :empresa_id)
    end
end
