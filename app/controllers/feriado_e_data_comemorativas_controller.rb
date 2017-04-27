class FeriadoEDataComemorativasController  < Support::InsideController
  before_action :set_feriado_e_data_comemorativa, only: [:show, :edit, :update, :destroy]

  def index
    @feriado_e_data_comemorativas = FeriadoEDataComemorativa.all
    respond_to do |format|
      format.html # index.html.haml
      format.json # no block here
    end
  end

  def show
  end

  def new
    @feriado_e_data_comemorativa = FeriadoEDataComemorativa.new
  end

  def edit
  end

  def create
    @feriado_e_data_comemorativa = FeriadoEDataComemorativa.new(resource_params)
    if @feriado_e_data_comemorativa.save
      redirect_to empresa_feriado_e_data_comemorativas_path(current_user.empresa), notice: 'Data cadastrada com sucesso.'
    else
      render :new
    end
  end

  def update
    if @feriado_e_data_comemorativa.update(resource_params)
      redirect_to @feriado_e_data_comemorativa, notice: 'Data atualizada com sucesso'
    else
      render :edit
    end
  end

  def destroy
    @feriado_e_data_comemorativa.destroy
    redirect_to :back
  end

  private
    def set_feriado_e_data_comemorativa
      @feriado_e_data_comemorativa = FeriadoEDataComemorativa.find(params[:id])
    end

    def resource_params
      params.require(:feriado_e_data_comemorativa).permit(:data, :descricao)
    end
end