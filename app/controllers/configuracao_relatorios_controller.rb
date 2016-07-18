class ConfiguracaoRelatoriosController < ApplicationController
  load_and_authorize_resource param_method: :resource_params

  respond_to :html

  def index
    @configuracao_relatorios = ConfiguracaoRelatorio.da_empresa_atual(empresa_atual["id"])
    respond_with(@configuracao_relatorios)
  end

  def show
    respond_with(@configuracao_relatorio)
  end

  def new
    respond_with(@configuracao_relatorio)
  end

  def edit
  end

  def create
    @configuracao_relatorio.associado_com_a_empresa=empresa_atual
    if @configuracao_relatorio.save
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: "Configuracao de Relatório")
    end
    redirect_to edit_configuracao_relatorio_path(@configuracao_relatorio)
  end

  def update
    @configuracao_relatorio.associado_com_a_empresa=empresa_atual
    if @configuracao_relatorio.update(resource_params)
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @configuracao_relatorio.class)
    end
    redirect_to edit_configuracao_relatorio_path(@configuracao_relatorio)
  end

  def destroy
    if @configuracao_relatorio.destroy
      flash[:success] = t('flash.actions.create.success', resource_name: "Configuracao de Relatório")
      respond_with nil, location: configuracao_relatorios_path
    else
      flash[:error] = t('flash.actions.destroy.error', resource_name: "Configuracao de Relatório")
    end
  end

  private
    def resource_params
      params.require(:configuracao_relatorio).permit(:nome_empresa, :cnpj,
                                                     :telefone, :endereco,
                                                     :bairro, :cidade_estado,
                                                     :email, :empresa_id, :logo)
    end
end
