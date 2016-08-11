class Painel::DashboardsController < ApplicationController
  before_action :authenticate_master!
  layout 'admin'

  def index
  end

  def import_permissoes_to_company
    @empresa = Painel::Empresa.find(params[:painel_empresa_permissao][:empresa_id])
    if params[:check_all]
      if @empresa.import_todas_permissoes
        flash[:info] = "Todas Permissoes vinculadas com sucesso."
      else
        flash[:warning] = "Permissoes não foram vinculadas!"
      end
    elsif params[:painel_empresa_permissao]
      @empresa.import_permissoes(params[:painel_empresa_permissao])
    end
    redirect_back(fallback_location: @empresa)
  end

  private
    def resource_params
      params.require(:empresa_permissao).permit(:empresa_id, permissao_ids: [])
    end
end
