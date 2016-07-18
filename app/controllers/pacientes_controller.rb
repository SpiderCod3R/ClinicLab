class PacientesController < ApplicationController
  load_and_authorize_resource param_method: :resource_params
  before_action :set_estados, only: [:new, :edit, :create, :update]
  before_action :set_convenios, only: [:new, :edit, :create, :update]
  respond_to :html

  def index
    @pacientes = Paciente.da_empresa_atual(empresa_atual["id"])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @paciente.associado_com_a_empresa=empresa_atual
    if @paciente.salvar
      flash[:success] = t('flash.actions.create.success', resource_name: "Paciente")
      redirect_to new_paciente_path
    else
      render :new
    end
  end

  def update
    if @paciente.atualizar(resource_params)
      flash[:success] = t('flash.actions.update.notice', resource_name: "Paciente")
      redirect_to pacientes_path
    else
      render :edit
    end
  end

  def destroy
    if @paciente.destroy
      flash[:notice]= t('flash.actions.destroy.success', resource_name: "Paciente")
      respond_with nil, location: pacientes_path
    else
      flash[:alert]= t('flash.actions.destroy.alert', resource_name: "Paciente")
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
      params.require(:paciente).permit(:nome, :rg, :cpf,:data_nascimento,
                                       :telefone, :nome_da_mae, :endereco,
                                       :bairro, :estado_id, :cidade_id,
                                       :empresa_id, :convenio_id, :cep, :celular)
    end
end
