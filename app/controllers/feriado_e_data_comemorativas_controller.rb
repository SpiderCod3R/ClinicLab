class FeriadoEDataComemorativasController < ApplicationController
  before_action :set_feriado_e_data_comemorativa, only: [:show, :edit, :update, :destroy]

  # GET /feriado_e_data_comemorativas
  # GET /feriado_e_data_comemorativas.json
  def index
    @feriado_e_data_comemorativas = FeriadoEDataComemorativa.all
  end

  # GET /feriado_e_data_comemorativas/1
  # GET /feriado_e_data_comemorativas/1.json
  def show
  end

  # GET /feriado_e_data_comemorativas/new
  def new
    @feriado_e_data_comemorativa = FeriadoEDataComemorativa.new
  end

  # GET /feriado_e_data_comemorativas/1/edit
  def edit
  end

  # POST /feriado_e_data_comemorativas
  # POST /feriado_e_data_comemorativas.json
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

  # PATCH/PUT /feriado_e_data_comemorativas/1
  # PATCH/PUT /feriado_e_data_comemorativas/1.json
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

  # DELETE /feriado_e_data_comemorativas/1
  # DELETE /feriado_e_data_comemorativas/1.json
  def destroy
    @feriado_e_data_comemorativa.destroy
    respond_to do |format|
      format.html { redirect_to feriado_e_data_comemorativas_url, notice: 'Feriado e data comemorativa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feriado_e_data_comemorativa
      @feriado_e_data_comemorativa = FeriadoEDataComemorativa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feriado_e_data_comemorativa_params
      params.require(:feriado_e_data_comemorativa).permit(:data, :descricao)
    end
end
