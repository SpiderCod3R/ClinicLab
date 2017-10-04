class GrupoExameProcedimentosController < ApplicationController
  before_action :set_grupo_exame_procedimento, only: [:show, :edit, :update, :destroy]

  # GET /grupo_exame_procedimentos
  # GET /grupo_exame_procedimentos.json
  def index
    @grupo_exame_procedimentos = GrupoExameProcedimento.all
  end

  # GET /grupo_exame_procedimentos/1
  # GET /grupo_exame_procedimentos/1.json
  def show
  end

  # GET /grupo_exame_procedimentos/new
  def new
    @grupo_exame_procedimento = GrupoExameProcedimento.new
  end

  # GET /grupo_exame_procedimentos/1/edit
  def edit
  end

  # POST /grupo_exame_procedimentos
  # POST /grupo_exame_procedimentos.json
  def create
    @grupo_exame_procedimento = GrupoExameProcedimento.new(grupo_exame_procedimento_params)

    respond_to do |format|
      if @grupo_exame_procedimento.save
        format.html { redirect_to @grupo_exame_procedimento, notice: 'Grupo exame procedimento was successfully created.' }
        format.json { render :show, status: :created, location: @grupo_exame_procedimento }
      else
        format.html { render :new }
        format.json { render json: @grupo_exame_procedimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grupo_exame_procedimentos/1
  # PATCH/PUT /grupo_exame_procedimentos/1.json
  def update
    respond_to do |format|
      if @grupo_exame_procedimento.update(grupo_exame_procedimento_params)
        format.html { redirect_to @grupo_exame_procedimento, notice: 'Grupo exame procedimento was successfully updated.' }
        format.json { render :show, status: :ok, location: @grupo_exame_procedimento }
      else
        format.html { render :edit }
        format.json { render json: @grupo_exame_procedimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grupo_exame_procedimentos/1
  # DELETE /grupo_exame_procedimentos/1.json
  def destroy
    @grupo_exame_procedimento.destroy
    respond_to do |format|
      format.html { redirect_to grupo_exame_procedimentos_url, notice: 'Grupo exame procedimento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grupo_exame_procedimento
      @grupo_exame_procedimento = GrupoExameProcedimento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grupo_exame_procedimento_params
      params.fetch(:grupo_exame_procedimento, {})
    end
end
