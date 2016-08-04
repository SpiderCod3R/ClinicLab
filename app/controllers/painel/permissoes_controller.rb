class Painel::PermissoesController < ApplicationController
  before_action :set_painel_permissao, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @painel_permissoes = Painel::Permissao.all
    respond_with(@painel_permissoes)
  end

  def show
    respond_with(@painel_permissao)
  end

  def new
    @painel_permissao = Painel::Permissao.new
    respond_with(@painel_permissao)
  end

  def edit
  end

  def create
    @painel_permissao = Painel::Permissao.new(painel_permissao_params)
    @painel_permissao.save
    respond_with(@painel_permissao)
  end

  def update
    @painel_permissao.update(painel_permissao_params)
    respond_with(@painel_permissao)
  end

  def destroy
    @painel_permissao.destroy
    respond_with(@painel_permissao)
  end

  private
    def set_painel_permissao
      @painel_permissao = Painel::Permissao.find(params[:id])
    end

    def painel_permissao_params
      params.require(:painel_permissao).permit(:nome, :model_class)
    end
end
