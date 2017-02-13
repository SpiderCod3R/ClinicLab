class CargosController < Support::InsideController
  load_and_authorize_resource param_method: :resource_params

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
      redirect_to new_cargo_path
    else
      render :new
    end
  end

  def update
    @cargo.update(resource_params)

    if @cargo.update(resource_params)
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cargo.class)
      redirect_to cargos_path
    else
      render :edit
    end
  end

  def destroy
    if @cargo.destroy
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cargo.class)
      redirect_to cargos_url
    else
      flash[:alert] = t("flash.actions.#{__method__}.alert", resource_name: @cargo.class)
    end
  end

  private
    def resource_params
      params.require(:cargo).permit(:nome, :status, :empresa_id)
    end
end
