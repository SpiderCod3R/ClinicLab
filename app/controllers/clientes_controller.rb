class ClientesController < Support::ClienteSupportController
  before_action :set_pdf_params, only:[:update]

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
    if params[:cliente][:id].present?
      @cliente = Cliente.find(params[:cliente][:id])
      @cliente.manage_convenios(session[:convenios_attributes]) if !session[:convenios_attributes].nil?
      if @cliente.update(resource_params)
        redirect_to new_empresa_cliente_path(current_user.empresa)
        flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
      end
    else
      @cliente = current_user.empresa.clientes.build(resource_params)
      if @cliente.save
        @cliente.manage_convenios(session[:convenios_attributes]) if !session[:convenios_attributes].nil?
        redirect_to new_empresa_cliente_path(current_user.empresa)
        flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
      else
        render :new
      end
    end
  end

  def update
    session[:cliente_id] = @cliente.id
    get_historicos
    if !params[:cliente][:cliente_pdf_upload][:pdf].nil?
      if params[:cliente][:cliente_pdf_upload][:anotacoes] != ""
        if @cliente.update(resource_params)
          if !params[:cliente][:cliente_pdf_upload].nil?
            if params[:cliente][:cliente_pdf_upload][:anotacoes] != "" and params[:cliente][:cliente_pdf_upload][:pdf] != ""
              @cliente.upload_files(params[:cliente][:cliente_pdf_upload])
            end
          end
          @cliente.salva_imagens_externas(@imagens_externas_params) if @imagens_externas_params.present?
          @cliente.manage_convenios(session[:convenios_attributes]) if !session[:convenios_attributes].nil?
          @cliente.salva_sadts(params[:cliente][:sadt]) if params[:cliente][:sadt].present?
          flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
          redirect_to edit_empresa_cliente_path(current_user.empresa, @cliente)
        else
          send_back_with_error
          render :edit
        end
      else
        send_back_with_error
        flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Cliente") + " É necessário informar um nome para o PDF."
        render :edit
      end
    else
      @cliente.salva_imagens_externas(@imagens_externas_params) if @imagens_externas_params.present?
      if @cliente.update(resource_params)
        @cliente.manage_convenios(session[:convenios_attributes]) if !session[:convenios_attributes].nil?
        @cliente.salva_sadts(params[:cliente][:sadt]) if params[:cliente][:sadt].present?
        flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
        redirect_to edit_empresa_cliente_path(current_user.empresa, @cliente)
      else
        send_back_with_error
        render :edit
      end
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

  def change_convenio
    @cliente = Cliente.find(params[:cliente_id])
    # binding.pry
    @cliente.cliente_convenios.update_all(utilizando_agora: 0)
    @change_cliente_convenio = @cliente.cliente_convenios.find(params[:cliente_convenio_id])
    @change_cliente_convenio.update_attributes(utilizando_agora: 1)
  end

  private
    def set_pdf_params
      @pdf_params = params[:cliente][:cliente_pdf_upload]
    end
end
