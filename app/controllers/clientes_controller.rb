class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  before_action :set_estados, only: [:new, :edit, :create, :update]

  respond_to :html

  def index
    @clientes = Cliente.da_empresa(current_usuario.empresa_id).pelo_nome
    respond_with(@clientes)
  end

  def show
    session[:cliente_id] = @cliente.id
    respond_with(@cliente)
  end

  def new
    session[:cliente_id] = nil
    @cliente = current_usuario.empresa.clientes.build
    get_historicos
    respond_with(@cliente)
  end

  def edit
    session[:cliente_id] = @cliente.id
    get_historicos
  end

  def create
    @cliente = current_usuario.empresa.clientes.build(cliente_params)
    get_historicos
    if @cliente.save
      redirect_to new_cliente_path
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
    else
      render :new
    end
  end

  def update
    @cliente = current_usuario.empresa.clientes.build(cliente_params)
    session[:cliente_id] = @cliente.id
    get_historicos
    @cliente.atualiza_cliente(cliente_params)
    redirect_to new_cliente_path
  end

  def retorna_historico
    unless params[:historico_id].empty?
      set_historico
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

  def salva_historico
    unless params[:historico].empty?
      @historico = Historico.new
      @historico.indice = params[:historico][:indice]
      @historico.idade = params[:historico][:idade]
      @historico.usuario_id = current_usuario.id
      @historico.cliente_id = session[:cliente_id]
      @historico.save
    end
    get_historicos
    respond_to do |format|
      format.html
      format.json { render json: session[:cliente_id].as_json }
    end
  end

  def atualiza_historico
    unless params[:historico].empty?
      @historico = Historico.find(params[:historico][:id])
      @historico.update_columns(indice: params[:historico][:indice])
    end
    get_historicos
    respond_to do |format|
      format.html
      format.json { render json: session[:cliente_id].as_json }
    end
  end

  def destroy
    @cliente.destroy
    respond_with(@cliente)
    session[:cliente_id] = nil
  end

  private

    def set_estados
      @estados = Estado.pelo_nome
    end

    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    def set_historico
      @historico = Historico.find(params[:historico_id])
    end

    def get_historicos
      @cliente ||= Cliente.find(session[:cliente_id])
      @historicos = Historico.where(cliente_id: @cliente.id).order('updated_at DESC')
    end

    def cliente_params
      params.require(:cliente).permit(:id,
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
                                      historico_attributes: [:indice, :idade, :usuario_id, :cliente_id]
                                      )
    end
end
