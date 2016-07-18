class CabecsController < ApplicationController
  before_action :set_cabec, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @cabecs = Cabec.all
    respond_with(@cabecs)
  end

  def show
    respond_with(@cabec)
  end

  def new
    @cabec = Cabec.new
    respond_with(@cabec)
  end

  def edit
  end

  def create
    @cabec = Cabec.new(cabec_params)
    @cabec.save
    flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cabec.class)
    redirect_to new_cabec_path
  end

  def update
    @cabec.update(cabec_params)
    respond_with(@cabec)
  end

  def destroy
    @cabec.destroy
    respond_with(@cabec)
  end

  private
    def set_cabec
      @cabec = Cabec.find(params[:id])
    end

    def cabec_params
      params.require(:cabec).permit(:nome, :status, :texto)
    end
end
