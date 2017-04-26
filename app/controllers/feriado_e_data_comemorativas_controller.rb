class FeriadoEDataComemorativasController  < Support::InsideController
  before_action :set_feriado_e_data_comemorativa, only: [:show, :edit, :update, :destroy]

  def index
    @feriado_e_data_comemorativas = FeriadoEDataComemorativa.all
  end

  def show
  end

  def new
    @feriado_e_data_comemorativa = FeriadoEDataComemorativa.new
  end

  def edit
  end

  def create
    @feriado_e_data_comemorativa = FeriadoEDataComemorativa.new(feriado_e_data_comemorativa_params)

    respond_to do |format|
      if @feriado_e_data_comemorativa.save
        format.html { redirect_to @feriado_e_data_comemorativa, notice: 'Feriado e data comemorativa was successfully created.' }
        format.json { render :show, status: :created, location: @feriado_e_data_comemorativa }
      else
        format.html { render :new }
        format.json { render json: @feriado_e_data_comemorativa.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feriado_e_data_comemorativa.update(feriado_e_data_comemorativa_params)
        format.html { redirect_to @feriado_e_data_comemorativa, notice: 'Feriado e data comemorativa was successfully updated.' }
        format.json { render :show, status: :ok, location: @feriado_e_data_comemorativa }
      else
        format.html { render :edit }
        format.json { render json: @feriado_e_data_comemorativa.errors, status: :unprocessable_entity }
      end
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

    def feriado_e_data_comemorativa_params
      params.require(:feriado_e_data_comemorativa).permit(:data, :descricao)
    end
end