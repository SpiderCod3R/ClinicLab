class ConveniosController < ApplicationController
  load_and_authorize_resource param_method: :resource_params

  def index
    @search = Convenio.where(empresa_id: current_usuario.empresa_id).ransack(params[:q])
    @convenios = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
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
    @convenio.empresa_id = current_usuario.empresa_id
    if @convenio.save
      redirect_to new_convenio_path
      flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: "Convênio")
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Convênio")
      render :new
    end
  end

  def update
    if @convenio.update(resource_params)
      redirect_to convenios_path
      flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: "Convênio")
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Convênio")
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
