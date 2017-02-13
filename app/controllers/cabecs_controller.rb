class CabecsController < Support::InsideController
  before_action :set_cabec, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @search = Cabec.where(empresa: current_user.empresa).ransack(params[:q])
    @cabecs = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
  end

  def show
    respond_with(@cabec)
  end

  def new
    @cabec = current_user.empresa.cabecs.build
    respond_with(@cabec)
  end

  def edit
  end

  def create
    @cabec = current_user.empresa.cabecs.build(cabec_params)
    if @cabec.save
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cabec.class)
      redirect_to new_empresa_cabec_path(current_user.empresa)
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Cabec")
      render :new
    end
  end

  def update
    if @cabec.update(cabec_params)
      redirect_to empresa_cabec_path(current_user.empresa, @cabec)
    else
      render :edit
    end
    respond_with(@cabec)
  end

  def destroy
    @cabec.destroy
    respond_with(@cabec)
  end

  private
    def set_cabec
      @cabec = Cabec.find(params[:id])
    end

    def cabec_params
      params.require(:cabec).permit(:nome, :status, :texto)
    end
end
