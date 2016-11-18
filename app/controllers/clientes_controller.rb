class ClientesController < Support::ClienteSupportController
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
end
