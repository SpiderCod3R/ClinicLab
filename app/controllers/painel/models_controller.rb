class Painel::ModelsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :find_model, only: [:edit, :update, :destroy]
  respond_to :html

  def index
    @models = Gclinic::Model.order("name ASC").page params[:page]
    @model = Gclinic::Model.new
    respond_with(@models)
  end

  def edit
  end

  def create
    @model = Gclinic::Model.new(resource_params)
    @model.save
    respond_to &:js
  end

  def update
    @model.update(resource_params)
    respond_to &:js
  end

  def destroy
    if @model.destroy
      redirect_to :back, notice: "O modelo foi excluido." and return
    else
      redirect_to :back, error: "O modelo não pôde ser excluido." and return
    end
  end

  private
    def find_model
      @model = Gclinic::Model.find(params[:id])
    end

    def resource_params
      params.require(:gclinic_model).permit(:name, :model_class)
    end
end
