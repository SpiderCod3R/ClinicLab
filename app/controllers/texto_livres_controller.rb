class TextoLivresController < ApplicationController
  before_action :set_texto_livre, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @texto_livres = TextoLivre.all
    respond_with(@texto_livres)
  end

  def show
    respond_with(@texto_livre)
  end

  def new
    @texto_livre = TextoLivre.new
    respond_with(@texto_livre)
  end

  def edit
  end

  def create
    @texto_livre = TextoLivre.new(texto_livre_params)
    if @texto_livre.save
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @texto_livre.class)
      redirect_to new_texto_livre_path
    else
      render :new
    end
  end

  def update
    @texto_livre.update(texto_livre_params)
    respond_with(@texto_livre)
  end

  def destroy
    @texto_livre.destroy
    respond_with(@texto_livre)
  end

  private
    def set_texto_livre
      @texto_livre = TextoLivre.find(params[:id])
    end

    def texto_livre_params
      params.require(:texto_livre).permit(:nome, :texto)
    end
end
