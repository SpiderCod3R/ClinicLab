class SadtExameProcedimentosController < ApplicationController
  before_action :set_sadt_exame_procedimento, only: [:show, :edit, :update, :destroy]

  # GET /sadt_exame_procedimentos
  # GET /sadt_exame_procedimentos.json
  def index
    @sadt_exame_procedimentos = SadtExameProcedimento.all
  end

  # GET /sadt_exame_procedimentos/1
  # GET /sadt_exame_procedimentos/1.json
  def show
  end

  # GET /sadt_exame_procedimentos/new
  def new
    @sadt_exame_procedimento = SadtExameProcedimento.new
  end

  # GET /sadt_exame_procedimentos/1/edit
  def edit
  end

  # POST /sadt_exame_procedimentos
  # POST /sadt_exame_procedimentos.json
  def create
    @sadt_exame_procedimento = SadtExameProcedimento.new(sadt_exame_procedimento_params)

    respond_to do |format|
      if @sadt_exame_procedimento.save
        format.html { redirect_to @sadt_exame_procedimento, notice: 'Sadt exame procedimento was successfully created.' }
        format.json { render :show, status: :created, location: @sadt_exame_procedimento }
      else
        format.html { render :new }
        format.json { render json: @sadt_exame_procedimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sadt_exame_procedimentos/1
  # PATCH/PUT /sadt_exame_procedimentos/1.json
  def update
    respond_to do |format|
      if @sadt_exame_procedimento.update(sadt_exame_procedimento_params)
        format.html { redirect_to @sadt_exame_procedimento, notice: 'Sadt exame procedimento was successfully updated.' }
        format.json { render :show, status: :ok, location: @sadt_exame_procedimento }
      else
        format.html { render :edit }
        format.json { render json: @sadt_exame_procedimento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sadt_exame_procedimentos/1
  # DELETE /sadt_exame_procedimentos/1.json
  def destroy
    @sadt_exame_procedimento.destroy
    respond_to do |format|
      format.html { redirect_to sadt_exame_procedimentos_url, notice: 'Sadt exame procedimento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sadt_exame_procedimento
      @sadt_exame_procedimento = SadtExameProcedimento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sadt_exame_procedimento_params
      params.fetch(:sadt_exame_procedimento, {})
    end
end
