class ReceituariosController < ApplicationController
  before_action :set_receituario, only: [:show, :edit, :update, :destroy]

  def index
    @search = Receituario.where(empresa: current_usuario.empresa).ransack(params[:q])
    @receituarios = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
  end

  def show
  end

  def new
    @receituario = current_usuario.empresa.receituarios.build
  end

  def edit
  end

  def create
    @receituario = current_usuario.empresa.receituarios.build(receituario_params)

    respond_to do |format|
      if @receituario.save
        format.html { redirect_to empresa_receituario_path(current_usuario.empresa, @receituario), notice: 'Receituario was successfully created.' }
        format.json { render :show, status: :created, location: @receituario }
      else
        format.html { render :new }
        format.json { render json: @receituario.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @receituario.update(receituario_params)
        format.html { redirect_to empresa_receituario_path(current_usuario.empresa, @receituario), notice: 'Receituario was successfully updated.' }
        format.json { render :show, status: :ok, location: @receituario }
      else
        format.html { render :edit }
        format.json { render json: @receituario.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @receituario.destroy
    respond_to do |format|
      format.html { redirect_to empresa_receituarios_url(current_usuario.empresa), notice: 'Receituario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_receituario
      @receituario = Receituario.friendly.find(params[:id])
    end

    def receituario_params
      params.require(:receituario).permit(:nome, :receita)
    end
end
