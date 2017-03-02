class ClientesController < Support::ClienteSupportController
  respond_to :html

  def index
    # @clientes = Cliente.da_empresa(current_usuario.empresa_id).pelo_nome
    # respond_with(@clientes)
    @search = Cliente.da_empresa(current_usuario.empresa_id).ransack(params[:q])
    @clientes = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
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
    load_tabs
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
    if @cliente.update(resource_params)
      salva_imagens_externas
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
      redirect_to :back
    else
      send_back_with_error
    end
  end

  def destroy
    @cliente.destroy
    respond_with(@cliente)
    session[:cliente_id] = nil
  end

  private
    def send_back_with_error
      if params[:page].permitted?
        @@page = params[:page]
      else
        @@page = 7
      end

      @cliente_texto_livre     = @cliente.cliente_texto_livres.first
      @cliente_collection_pdfs = @cliente.cliente_pdf_uploads.ultima_data.page(@@page).per(2)
      @cliente_pdf_uploads     = @cliente.cliente_pdf_uploads.build
      render :edit
    end
end