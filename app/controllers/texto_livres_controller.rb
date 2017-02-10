class TextoLivresController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:servico] || params[:search]
      @texto_livres = TextoLivre.where(empresa_id: current_usuario.empresa_id).search(params[:servico]['id'], params[:search]).order("created_at DESC").page(params[:page]).per(10)
    else
      @texto_livres = TextoLivre.where(empresa_id: current_usuario.empresa_id).order("created_at DESC").page(params[:page]).per(10)
      respond_with(@texto_livres)
    end
  end

  def show
  end

  def show_texto_livre
    respond_to &:js
  end

  def new
    @texto_livre = TextoLivre.new
  end

  def edit
  end

  def create
    @texto_livre = TextoLivre.new(resource_params)
    @texto_livre.addEmpresa=current_usuario.empresa
    if @texto_livre.save
      redirect_to @texto_livre, notice: 'Texto livre was successfully created.'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @texto_livre.update(resource_params)
        format.html { redirect_to @texto_livre, notice: 'Texto livre was successfully updated.' }
        format.json { render :show, status: :ok, location: @texto_livre }
      else
        format.html { render :edit }
        format.json { render json: @texto_livre.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @texto_livre.destroy
    respond_to do |format|
      format.html { redirect_to texto_livres_url, notice: 'Texto livre was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def resource_params
      params.require(:texto_livre).permit(:nome, :servico_id, :content, :empresa_id)
    end
end
