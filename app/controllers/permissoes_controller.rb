class PermissoesController < ApplicationController
  before_action :set_permissao, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @permissoes = Permissao.all
    respond_with(@permissoes)
  end

  def show
    respond_with(@permissao)
  end

  def new
    @permissao = Permissao.new
    respond_with(@permissao)
  end

  def edit
  end

  def create
    @permissao = Permissao.new(permissao_params)
    @permissao.save
    respond_with(@permissao)
  end

  def update
    @permissao.update(permissao_params)
    respond_with(@permissao)
  end

  def destroy
    @permissao.destroy
    respond_with(@permissao)
  end

  private
    def set_permissao
      @permissao = Permissao.find(params[:id])
    end

    def permissao_params
      params.require(:permissao).permit(:nome, :model_class)
    end
end
