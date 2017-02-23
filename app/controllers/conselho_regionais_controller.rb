class ConselhoRegionaisController < Support::InsideController
  before_action :set_conselho_regional, only: [:show, :edit, :update, :destroy]

  def index
    if params[:status] || params[:id] || params[:sigla] || params[:search]
      @conselho_regionais = current_user.empresa.conselho_regionais.where(empresa: current_user.empresa).search(params[:status]['status'], params[:id]['id'], params[:sigla]['sigla'], params[:search]).order("created_at DESC").page(params[:page]).per(10)
    else
      @conselho_regionais = current_user.empresa.conselho_regionais.where(empresa: current_user.empresa).order("id DESC").page(params[:page]).per(10)
      respond_with(@conselho_regionais)
    end
  end

  def search
    @result = ConselhoRegional.all
  end

  def show
    respond_with(@conselho_regional)
  end

  def new
    @conselho_regional = current_user.empresa.conselho_regionais.build
    respond_with(@conselho_regional)
  end

  def edit
  end

  def create
    @conselho_regional = current_user.empresa.conselho_regionais.build(conselho_regional_params)
    if @conselho_regional.save
      flash[:notice] = t("flash.actions.#{__method__}.notice", resource_name: @conselho_regional.sigla)
      redirect_to new_empresa_conselho_regional_path(current_user.empresa)
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Conselho Regional")
      render :new
    end
  end

  def update
    @conselho_regional.update(conselho_regional_params)
    respond_with(@conselho_regional)
  end

  def destroy
    @conselho_regional.destroy
    respond_with(@conselho_regional)
  end

  private
    def set_conselho_regional
      @conselho_regional = ConselhoRegional.find(params[:id])
    end

    def conselho_regional_params
      params.require(:conselho_regional).permit(:sigla, :status, :descricao, :empresa_id)
    end
end
