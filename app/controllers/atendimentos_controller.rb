class AtendimentosController < ApplicationController
  load_and_authorize_resource
  before_action :set_estados, only: [:new, :edit, :create, :update]
  before_action :set_convenios, only: [:new, :edit, :create, :update]

  respond_to :html

  def index
    @atendimentos = Atendimento.da_empresa_atual(empresa_atual["id"])
    respond_with(@atendimentos)
  end

  def show
    respond_with(@atendimento)
  end

  def new
    respond_with(@atendimento)
  end

  def edit
  end

  def create
    @atendimento.associado_com_a_empresa=empresa_atual
    @atendimento, @message = @atendimento.create_resource(resource_params)

    if @message[:error].present?
      flash[:alert] = @message[:error]
      render :new
    elsif @message[:success].present?
      flash[:success] = @message[:success]
      redirect_to new_atendimento_path
    end
  end

  def update
    @atendimento.associado_com_a_empresa=empresa_atual
    @atendimento, @message = @atendimento.update_resource(resource_params)

    if @message[:error].present?
      flash[:alert] = @message[:error]
      render :edit
    elsif @message[:success].present?
      flash[:success] = @message[:success]
      redirect_to atendimentos_path
    end
  end

  def destroy
    if @atendimento.destroy
      flash[:notice]= t('flash.actions.destroy.success', resource_name: "Atendimento")
      respond_with nil, location: atendimentos_path
    else
      flash[:alert]= t('flash.actions.destroy.alert', resource_name: "Atendimento")
    end
  end

  private
    def set_estados
      @estados = Estado.pelo_nome
    end

    def set_convenios
      @convenios = Convenio.pelo_nome
    end

    def resource_params
      params.require(:atendimento).permit(:nome, :rg, :cpf, :data_nascimento,
                                          :telefone, :celular, :nome_da_mae,
                                          :endereco, :bairro, :cidade_id,
                                          :estado_id, :data, :hora, :convenio_id, :cep)
    end
end
