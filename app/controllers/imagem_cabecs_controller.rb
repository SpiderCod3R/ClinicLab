class ImagemCabecsController < Support::InsideController
  before_action :set_imagem_cabec, only: [:show, :edit, :update, :destroy]

  def index
    @search = ImagemCabec.where(empresa: current_user.empresa).ransack(params[:q])
    @imagem_cabecs = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
  end

  def show
    respond_with(@imagem_cabec)
  end

  def new
    @imagem_cabec = current_user.empresa.imagem_cabecs.build
    respond_with(@imagem_cabec)
  end

  def edit
  end

  def create
    @imagem_cabec = current_user.empresa.imagem_cabecs.build(imagem_cabec_params)
    if @imagem_cabec.save
      flash[:success] = t('flash.actions.create.success', resource_name: "Imagem Cabec")
      redirect_to new_empresa_imagem_cabec_path(current_user.empresa)
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "ImagemCabec")
      render :new
    end
  end

  def update
    if @imagem_cabec.update(imagem_cabec_params)
      redirect_to empresa_imagem_cabecs_path(current_user.empresa), notice: t('flash.actions.update.success', resource_name: "Imagem Cabec")
    else
      render :edit
    end
  end

  def destroy
    @imagem_cabec.destroy
    respond_with(@imagem_cabec)
  end

  private
    def set_imagem_cabec
      @imagem_cabec = ImagemCabec.find(params[:id])
    end

    def imagem_cabec_params
      params.require(:imagem_cabec).permit(:imagem, :nome)
    end
end
