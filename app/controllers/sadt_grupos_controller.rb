class SadtGruposController < ApplicationController
  before_action :set_sadt_grupo, only: [:show, :edit, :update, :destroy]

  # GET /sadt_grupos
  # GET /sadt_grupos.json
  def index
    @sadt_grupos = SadtGrupo.all
  end

  # GET /sadt_grupos/1
  # GET /sadt_grupos/1.json
  def show
  end

  # GET /sadt_grupos/new
  def new
    @sadt_grupo = SadtGrupo.new
  end

  # GET /sadt_grupos/1/edit
  def edit
  end

  # POST /sadt_grupos
  # POST /sadt_grupos.json
  def create
    @sadt_grupo = SadtGrupo.new(sadt_grupo_params)

    respond_to do |format|
      if @sadt_grupo.save
        format.html { redirect_to @sadt_grupo, notice: 'Sadt Grupo was successfully created.' }
        format.json { render :show, status: :created, location: @sadt_grupo }
      else
        format.html { render :new }
        format.json { render json: @sadt_grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sadt_grupos/1
  # PATCH/PUT /sadt_grupos/1.json
  def update
    respond_to do |format|
      if @sadt_grupo.update(sadt_grupo_params)
        format.html { redirect_to @sadt_grupo, notice: 'Sadt Grupo was successfully updated.' }
        format.json { render :show, status: :ok, location: @sadt_grupo }
      else
        format.html { render :edit }
        format.json { render json: @sadt_grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sadt_grupos/1
  # DELETE /sadt_grupos/1.json
  def destroy
    @sadt_grupo.destroy
    respond_to do |format|
      format.html { redirect_to sadt_grupos_url, notice: 'Sadt Grupo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sadt_grupo
      @sadt_grupo = SadtGrupo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sadt_grupo_params
      params.fetch(:sadt_grupo, {})
    end
end
