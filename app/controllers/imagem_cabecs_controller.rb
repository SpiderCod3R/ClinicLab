class ImagemCabecsController < ApplicationController
  before_action :set_imagem_cabec, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @imagem_cabecs = ImagemCabec.all
    respond_with(@imagem_cabecs)
  end

  def show
    respond_with(@imagem_cabec)
  end

  def new
    @imagem_cabec = ImagemCabec.new
    respond_with(@imagem_cabec)
  end

  def edit
  end

  def create
    @imagem_cabec = ImagemCabec.new(imagem_cabec_params)
    @imagem_cabec.save
    flash[:success] = t('flash.actions.create.success', resource_name: "Imagem Cabec")
    redirect_to new_imagem_cabec_path
  end

  def update
    @imagem_cabec.update(imagem_cabec_params)
    respond_with(@imagem_cabec)
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
