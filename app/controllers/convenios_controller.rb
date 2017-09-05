class ConveniosController < Support::InsideController
  load_and_authorize_resource
  before_action :find_convenio, only: [:show, :edit, :update, :destroy]

  def index
    @search = Convenio.ransack(params[:q])
    @convenios = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
  end

  def show
    respond_with(@convenio)
  end

  def new
    @convenio = current_user.empresa.convenios.build
    respond_with(@convenio)
  end

  def edit
    respond_with(@convenio)
  end

  def create
    @convenio = current_user.empresa.convenios.build(resource_params)
    if @convenio.save
      redirect_to new_empresa_convenio_path(current_user.empresa)
      flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: "Convênio")
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Convênio")
      render :new
    end
  end

  def update
    if @convenio.update(resource_params)
      redirect_to empresa_convenios_path(current_user.empresa)
      flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: "Convênio")
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Convênio")
      render :edit
    end
  end

  def destroy
    @convenio.destroy
    redirect_to empresa_convenios_url(current_user.empresa)
    flash[:notice] = t("flash.actions.#{__method__}.success", resource_name: "Convênio")
  end

  private
    def find_convenio
      @convenio = Convenio.find(params[:id])
    end

    def resource_params
      params.require(:convenio).permit(:nome, :valor, :status, :empresa_id)
    end
end
