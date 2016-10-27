class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  before_action :set_estados, only: [:new, :edit, :create, :update, :ficha]

  respond_to :html

  def index
    @clientes = Cliente.da_empresa(current_usuario.empresa_id).pelo_nome
    respond_with(@clientes)
  end

  def show
    respond_with(@cliente)
  end

  def new
    @cliente = current_usuario.empresa.clientes.build
    respond_with(@cliente)
  end

  def edit
  end

  def create
    @cliente = current_usuario.empresa.clientes.build(cliente_params)
    if @cliente.save
      redirect_to new_cliente_path
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
    else
      render :new
    end
  end

  def update
    @cliente.update(cliente_params)
    respond_with(@cliente)
  end

  def destroy
    @cliente.destroy
    respond_with(@cliente)
  end

  def ficha
    # binding.pry
    @agenda = Agenda.find(params[:agenda_id])
    @cliente = current_usuario.empresa.clientes.build
    @cliente.recupera_agenda_dados(@agenda)
    render :new
  end

  private

    def set_estados
      @estados = Estado.pelo_nome
    end

    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    def cliente_params
      params.require(:cliente).permit(
        :status,
        :nome,
        :cpf,
        :endereco,
        :complemento,
        :bairro,
        :estado_id,
        :cidade_id,
        :empresa_id,
        :foto,
        :email,
        :telefone,
        :cargo_id,
        :status_convenio,
        :matricula,
        :plano,
        :validade_carteira,
        :produto,
        :titular,
        :convenio_id,
        :nascimento,
        :sexo,
        :rg,
        :estado_civil
        )
    end
end
