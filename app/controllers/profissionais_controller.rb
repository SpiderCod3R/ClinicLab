class ProfissionaisController < ApplicationController
  before_action :set_estados, only: [:new, :edit, :create, :update]
  before_action :set_conselhos_regionais, only: [:new, :edit, :create, :update]
  before_action :set_operadoras, only: [:new, :edit, :create, :update]
  before_action :set_cargos, only: [:new, :edit, :create, :update]
  before_action :find_profissional, only: [:show, :edit, :update, :destroy]

  def index
    if params[:status] || params[:cargo] || params[:nome]
      @profissionais = Profissional.where(empresa_id: current_usuario.empresa_id).search(params[:status]['status'], params[:cargo]['id'], params[:nome]).order("created_at DESC").page(params[:page]).per(10)
    else
      @profissionais = Profissional.where(empresa_id: current_usuario.empresa_id).order("created_at DESC").page(params[:page]).per(10)
      respond_with(@profissionais)
    end
  end

  def show
    respond_with(@profissional)
  end

  def new
    @profissional = current_usuario.empresa.profissionais.build
    respond_with(@profissional)
  end

  def edit
  end

  def create
    @profissional = current_usuario.empresa.profissionais.build(resource_params)
    if @profissional.save
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @profissional.class)
      redirect_to new_profissional_path
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: @profissional.class)
      render :new
    end
  end

  def update
    # binding.pry
    if @profissional.update(resource_params)
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @profissional.class)
      redirect_to profissionais_path
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: @profissional.class)
      render :edit
    end
  end

  def destroy
    if @profissional.destroy
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @profissional.class)
      redirect_to profissionais_path
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: @profissional.class)
    end
  end

  private
    def find_profissional
      @profissional = Profissional.find(params[:id])
    end

    def set_cargos
      @cargos = Cargo.da_empresa_atual(current_usuario.empresa).pelo_nome
    end

    def set_estados
      @estados = Estado.pelo_nome
    end

    def set_operadoras
      @operadoras = Operadora.where(empresa_id: current_usuario.empresa.id).pelo_nome
    end

    def set_conselhos_regionais
      @conselhos_regionais = ConselhoRegional.where(empresa_id: current_usuario.empresa.id).pela_sigla
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
