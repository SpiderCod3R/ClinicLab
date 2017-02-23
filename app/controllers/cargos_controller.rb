class CargosController < Support::InsideController
  load_and_authorize_resource

  def index
    @search = Cargo.where(empresa_id: current_user.empresa_id).ransack(params[:q])
    @cargos = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
  end

  def show
    respond_with(@cargo)
  end

  def new
    @cargo = current_user.empresa.cargos.build
    respond_with(@cargo)
  end

  def edit
  end

  def create
    @cargo = current_user.empresa.cargos.build(resource_params)
    if @cargo.save
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cargo.class)
      redirect_to new_empresa_cargo_path(current_user.empresa)
    else
      render :new
    end
  end

  def update
    @cargo.update(resource_params)
    if @cargo.update(resource_params)
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cargo.class)
      redirect_to empresa_cargos_path(current_user.empresa)
    else
      render :edit
    end
  end

  def destroy
    if @cargo.destroy
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cargo.class)
      redirect_to empresa_cargos_url(current_user.empresa)
    else
      flash[:alert] = t("flash.actions.#{__method__}.alert", resource_name: @cargo.class)
    end
  end

  private
    def resource_params
      params.require(:cargo).permit(:nome, :status, :empresa_id)
    end
end
