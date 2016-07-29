class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  before_action :set_estados, only: [:new, :edit, :create, :update]

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
    @historicos = Historico.where(cliente_id: @cliente.id).order('updated_at DESC')
    respond_with(@cliente)
  end

  def edit
    @historicos = Historico.where(cliente_id: @cliente.id).order('updated_at DESC')
  end

  def create
    @cliente = current_usuario.empresa.clientes.build(cliente_params)
    @historicos = Historico.where(cliente_id: @cliente.id).order('updated_at DESC')
    if @cliente.save
      redirect_to new_cliente_path
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
    else
      render :new
    end
  end

  def update
    @historicos = Historico.where(cliente_id: @cliente.id).order('updated_at DESC')
    @cliente.update(cliente_params)
    respond_with(@cliente)
  end

  def retorna_historico
    unless params[:historico_id].empty?
      @historico = Historico.find(params[:historico_id])
      @dados_historico = {}
      @dados_historico[:data] = I18n.l(@historico.updated_at, format: :long)
      @dados_historico[:usuario] = @historico.usuario.nome
      @dados_historico[:idade] = @historico.idade
      @dados_historico[:indice] = @historico.indice
      respond_to do |format|
        format.html
        format.json { render json: @dados_historico.as_json }
      end
    end
  end

  def destroy
    @cliente.destroy
    respond_with(@cliente)
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
        :estado_civil,
        :nacionalidade,
        :naturalidade,
        historico_attributes: [:indice]
        )
    end
end
