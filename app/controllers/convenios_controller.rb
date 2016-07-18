class ConveniosController < ApplicationController
  load_and_authorize_resource param_method: :resource_params

  def index
    @convenios = Convenio.da_empresa_atual(empresa_atual["id"])
    respond_with(@convenios)
  end

  def show
    respond_with(@convenio)
  end

  def new
    respond_with(@convenio)
  end

  def edit
    respond_with(@convenio)
  end

  def create
    @convenio.associado_com_a_empresa=empresa_atual
    if @convenio.save
      redirect_to new_convenio_path
      flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: "Convênio")
    else
      render :new
    end
  end

  def update
    if @convenio.update(resource_params)
      redirect_to convenios_path
      flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: "Convênio")
    else
      render :edit
    end
  end

  def destroy
    @convenio.destroy
    redirect_to convenios_url
    flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: "Convênio")
  end

  private
    def resource_params
      params.require(:convenio).permit(:nome, :valor, :status, :empresa_id)
    end
end
