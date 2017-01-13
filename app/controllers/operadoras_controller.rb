class OperadorasController < ApplicationController
  load_and_authorize_resource
  before_action :find_operadora, except: [:index, :new, :create]

  def index
    @operadoras = Operadora.where(empresa_id: current_usuario.empresa_id)
    respond_with(@operadoras)
  end

  def show
    #find_operadora
  end

  def new
    @operadora = current_usuario.empresa.operadoras.build
  end

  def edit
    #find_operadora
  end

  def create
    @operadora = current_usuario.empresa.operadoras.build(resource_params)
    if @operadora.save
      redirect_to new_operadora_path, notice: t("flash.actions.#{__method__}.notice", resource_name: @operadora.nome)
    else
      render :new
    end
  end

  def update
    #find_operadora
    if @operadora.update(resource_params)
      redirect_to operadoras_path, notice: t("flash.actions.#{__method__}.notice", resource_name: @operadora.nome)
    else
      render :edit
    end
  end

  def destroy
    if @operadora.destroy
      redirect_to new_operadora_path, notice: t("flash.actions.#{__method__}.notice", resource_name: @operadora.nome)
    else
      redirect_to operadoras_path, alert: t("flash.actions.#{__method__}.alert", resource_name: @operadora.nome)
    end
  end

  private

  def find_operadora
    @operadora = Operadora.find(params[:id])
  end

  def resource_params
    params.require(:operadora).permit(:nome, :status)
  end
end
