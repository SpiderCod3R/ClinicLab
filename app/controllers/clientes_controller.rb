class ClientesController < Support::ClienteSupportController
  before_action :authenticate_usuario!
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
    @cliente_texto_livre = @cliente.cliente_texto_livres.first
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
    session[:cliente_id] = @cliente.id
    get_historicos
    @cliente.update(cliente_params)
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
    # get_historicos
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

  def include_texto_livre
    # binding.pry
    if params[:cliente_texto_livre][:id].to_i.eql?(0)
      @cliente_texto_livre = ClienteTextoLivre.include(params[:texto_livre])
    else
      @cliente_texto_livre = ClienteTextoLivre.find(params[:cliente_texto_livre][:id])
      @cliente_texto_livre.update_content(params)
    end

    respond_to do |format|
      format.html
      format.json { render json: session[:cliente_id].as_json }
    end
  end

  def destroy_cliente_texto_livre
    @cliente_texto_livre = ClienteTextoLivre.find(params[:id])
    @cliente_texto_livre.destroy
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
end