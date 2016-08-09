class Painel::DashboardsController < ApplicationController
  before_action :authenticate_master!
  layout 'admin'

  def index
  end

  def import_permissoes_to_company
    if params[:check_all]
      @empresa = Painel::Empresa.find(params[:painel_empresa_permissao][:empresa_id])
      @empresa.import_todas_permissoes
    elsif params[:painel_empresa_permissao]
    end
    redirect_back(fallback_location: @empresa)
  end
end
