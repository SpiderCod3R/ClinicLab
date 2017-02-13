class ConfiguracaoRelatoriosController < Support::InsideController
  load_and_authorize_resource param_method: :resource_params
  before_action :set_configuracao_relatorios, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @configuracao_relatorios = ConfiguracaoRelatorio.where(empresa: current_user.empresa)
    respond_with(@configuracao_relatorios)
  end

  def show
    respond_with(@configuracao_relatorio)
  end

  def new
    if current_user.empresa.has_report_conf?
      redirect_to empresa_configuracao_relatorio_path(current_user.empresa, current_user.empresa.configuracao_relatorio) and return
    else
      @configuracao_relatorio = current_user.empresa.build_configuracao_relatorio
      respond_with(@configuracao_relatorio)
    end
  end

  def edit
  end

  def create
    @configuracao_relatorio = current_user.empresa.build_configuracao_relatorio(resource_params)
    if @configuracao_relatorio.save
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: "Configuracao de Relatório")
      redirect_to empresa_configuracao_relatorio_path(@configuracao_relatorio.empresa,@configuracao_relatorio)
    else
      render :new, error: t("flash.actions.#{__method__}.error", resource_name: "Configuracao de Relatório")
    end
  end

  def update
    @configuracao_relatorio.associado_com_a_empresa=empresa_atual
    if @configuracao_relatorio.update(resource_params)
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @configuracao_relatorio.class)
    end
    redirect_to edit_configuracao_relatorio_path(@configuracao_relatorio)
  end

  def destroy
    # if @configuracao_relatorio.destroy
    #   flash[:success] = t('flash.actions.create.success', resource_name: "Configuracao de Relatório")
    #   respond_with nil, location: empresa_configuracao_relatorios_path(current_user.empresa)
    # else
    #   flash[:error] = t('flash.actions.destroy.error', resource_name: "Configuracao de Relatório")
    # end
  end

  private
    def set_configuracao_relatorios
      @configuracao_relatorio = ConfiguracaoRelatorio.find(params[:id])
    end

    def resource_params
      params.require(:configuracao_relatorio).permit(:nome_empresa, :cnpj,
                                                     :telefone, :endereco,
                                                     :bairro, :cidade_estado,
                                                     :email, :empresa_id, :logo)
    end
end
