class ClientesController < Support::ClienteSupportController
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
    if !@cliente.cliente_pdf_uploads.empty?
      @cliente_pdf_uploads = @cliente.cliente_pdf_uploads.build
    else
      @cliente_pdf_uploads = @cliente.cliente_pdf_uploads.build
    end
    # binding.pry
    @cliente_pdfs  = ClientePdfUpload.where(cliente_id: @cliente)
    get_historicos
  end

  def create
    @cliente = current_usuario.empresa.clientes.build(resource_params)
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
    @cliente.upload_files(params[:cliente][:cliente_pdf_upload]) if !params[:cliente][:cliente_pdf_upload][:pdf].nil?
    binding.pry
    if @cliente.update(resource_params)
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
      redirect_to :back
    else
      @cliente_pdf_uploads = @cliente.cliente_pdf_uploads.build if !@cliente.cliente_pdf_uploads.empty?
      @cliente_pdfs  = ClientePdfUpload.where(cliente_id: @cliente)
      render :edit
    end
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