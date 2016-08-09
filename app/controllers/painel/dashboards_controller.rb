class Painel::DashboardsController < ApplicationController
  before_action :authenticate_master!
  layout 'admin'

  def index
  end

  def import_permissoes_to_company
    if params[:check_all]
      @empresa = Painel::Empresa.find(params[:painel_empresa_permissao][:empresa_id])
      if @empresa.import_todas_permissoes
        flash[:info] = "Todas Permissoes vinculadas com sucesso."
      else
        flash[:warning] = "Permissoes não foram vinculadas!"
      end
    elsif params[:painel_empresa_permissao]
    end
    redirect_back(fallback_location: @empresa)
  end
end
