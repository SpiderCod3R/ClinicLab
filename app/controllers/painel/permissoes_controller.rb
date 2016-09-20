class Painel::PermissoesController < ApplicationController
  before_action :authenticate_master!
  layout 'admin'
  respond_to :html

  def index
    @permissoes = Painel::Permissao.order("nome ASC").page params[:page]
    @permissao = Painel::Permissao.new
    respond_with(@permissoes)
  end

  def edit
    @permissao = Painel::Permissao.find(params[:id])
  end

  def create
    @permissao = Painel::Permissao.new(permissao_params)
    @permissao.save
    respond_to &:js
  end

  def update
    @permissao = Painel::Permissao.find(params[:id])
    @permissao.update(permissao_params)
    respond_to &:js
  end

  def excluir
    @permissao_id = params[:permissao_id]
    @permissao = Painel::Permissao.find(params[:permissao_id])
    @permissao.destroy
    redirect_back(fallback_location: :index)
  end

  private
    def permissao_params
      params.require(:painel_permissao).permit(:nome, :model_class)
    end
end
