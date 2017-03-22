class ClientesController < Support::ClienteSupportController
  def index
    @search = Cliente.where(empresa: current_user.empresa).ransack(params[:q])
    @clientes = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
  end

  def show
    session[:cliente_id] = @cliente.id
    respond_with(@cliente)
  end

  def new
    session[:cliente_id] = nil
    @cliente = current_user.empresa.clientes.build
    get_historicos
    respond_with(@cliente)
  end

  def edit
    load_tabs
  end

  def create
    @cliente = current_user.empresa.clientes.build(resource_params)
    get_historicos
    if @cliente.save
      redirect_to new_empresa_cliente_path(current_user.empresa)
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
      if params[:imagens_externas].present?
        salva_imagens_externas
      end
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
      redirect_to empresa_cliente_path(current_user.empresa, @cliente)
    else
      send_back_with_error
      render :edit
    end
  end

  def destroy
    if @cliente.destroy
      redirect_to empresa_clientes_path(current_user.empresa)
      session[:cliente_id] = nil
    else
      flash[:success] = t("flash.actions.#{__method__}.error", resource_name: @cliente.class)
      redirect_to :back
    end
  end
end