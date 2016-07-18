class ConselhoRegionaisController < ApplicationController
  before_action :set_conselho_regional, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if params[:status] || params[:id] || params[:sigla] || params[:search]
      @conselho_regionais = ConselhoRegional.search(params[:status]['status'], params[:id]['id'], params[:sigla]['sigla'], params[:search]).order("created_at DESC")
      # binding.pry
    else
      @conselho_regionais = ConselhoRegional.all
      respond_with(@conselho_regionais)
    end
  end

  def search
    @result = ConselhoRegional.all
  end

  def show
    respond_with(@conselho_regional)
  end

  def new
    @conselho_regional = ConselhoRegional.new
    respond_with(@conselho_regional)
  end

  def edit
  end

  def create
    @conselho_regional = ConselhoRegional.new(conselho_regional_params)
    if @conselho_regional.save
      redirect_to new_conselho_regional_path, notice: t("flash.actions.#{__method__}.notice", resource_name: @conselho_regional.sigla)
    else
      render :new
    end
  end

  def update
    @conselho_regional.update(conselho_regional_params)
    respond_with(@conselho_regional)
  end

  def destroy
    @conselho_regional.destroy
    respond_with(@conselho_regional)
  end

  private
    def set_conselho_regional
      @conselho_regional = ConselhoRegional.find(params[:id])
    end

    def conselho_regional_params
      params.require(:conselho_regional).permit(:sigla, :status, :descricao)
    end
end
