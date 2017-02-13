class ProfissionaisController < Support::InsideController
  before_action :set_estados, only: [:new, :edit, :create, :update]
  before_action :set_conselhos_regionais, only: [:new, :edit, :create, :update]
  before_action :set_operadoras, only: [:new, :edit, :create, :update]
  before_action :set_cargos, only: [:new, :edit, :create, :update]
  before_action :find_profissional, only: [:show, :edit, :update, :destroy]

  def index
    if params[:status] || params[:cargo] || params[:nome]
      @profissionais = Profissional.where(empresa: current_user.empresa).search(params[:status]['status'], params[:cargo]['id'], params[:nome]).order("created_at DESC").page(params[:page]).per(10)
    else
      @profissionais = Profissional.where(empresa: current_user.empresa).order("created_at DESC").page(params[:page]).per(10)
      respond_with(@profissionais)
    end
  end

  def show
    respond_with(@profissional)
  end

  def new
    @profissional = current_user.empresa.profissionais.build
    respond_with(@profissional)
  end

  def edit
  end

  def create
    @profissional = current_user.empresa.profissionais.build(resource_params)
    if @profissional.save
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @profissional.class)
      redirect_to new_empresa_profissional_path(current_user.empresa)
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: @profissional.class)
      render :new
    end
  end

  def update
    if @profissional.update(resource_params)
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @profissional.class)
      redirect_to empresa_profissional_path(current_user.empresa, @profissional)
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: @profissional.class)
      render :edit
    end
  end

  def destroy
    if @profissional.destroy
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @profissional.class)
      redirect_to empresa_profissionais_path(current_user.empresa)
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: @profissional.class)
    end
  end

  private
    def find_profissional
      @profissional = Profissional.find(params[:id])
    end

    def set_cargos
      @cargos = current_user.empresa.cargos.by_name
    end

    def set_estados
      @estados = Estado.pelo_nome
    end

    def set_operadoras
      @operadoras = current_user.empresa.operadoras.by_name
    end

    def set_conselhos_regionais
      @conselhos_regionais = current_user.empresa.conselho_regionais.pela_sigla
    end

    def resource_params
      params.require(:profissional).permit(:nome,
                                           :imagem,
                                           :cargo_id,
                                           :empresa_id,
                                           :data_nascimento,
                                           :cpf,:rg, :telefone,
                                           :celular, :operadora_id,
                                           :conselho_regional_id, :estado_id,
                                           :endereco, :complemento, :bairro, :cidade_id, :status,
                                           :numero_conselho_regional)
    end
end
