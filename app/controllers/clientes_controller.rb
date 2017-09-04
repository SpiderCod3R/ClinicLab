class ClientesController < Support::ClienteSupportController
  before_action :set_pdf_params, only:[:update]
  before_action :set_imagens_externas, only:[:update]

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
      @cliente.manage_convenios(session[:convenios_attributes], session[:option_for_cliente_convenio]) if !session[:convenios_attributes].nil?
      if @cliente.update(resource_params)
        redirect_to new_empresa_cliente_path(current_user.empresa)
        flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
      end
    else
      @cliente = current_user.empresa.clientes.build(resource_params)
      # binding.pry
      if @cliente.save
        @cliente.manage_convenios(session[:convenios_attributes], session[:option_for_cliente_convenio]) if !session[:convenios_attributes].nil?
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
          @cliente.upload_files(params[:cliente][:cliente_pdf_upload])
          # @cliente.upload_files(@pdf_params) if @pdf_params.present?
          @cliente.salva_imagens_externas(@imagens_externas_params) if @imagens_externas_params.present?
          @cliente.manage_convenios(session[:convenios_attributes], session[:option_for_cliente_convenio]) if !session[:convenios_attributes].nil?
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
      if @cliente.update(resource_params)
        @cliente.salva_imagens_externas(@imagens_externas_params) if @imagens_externas_params.present?
        @cliente.manage_convenios(session[:convenios_attributes], session[:option_for_cliente_convenio]) if !session[:convenios_attributes].nil?
        flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
        redirect_to edit_empresa_cliente_path(current_user.empresa, @cliente)
      else
        send_back_with_error
        render :edit
      end
    end
  end

  # def update
  #   session[:cliente_id] = @cliente.id
  #   get_historicos
  #     if params[:cliente][:cliente_pdf_upload][:anotacoes] != ""
  #   if !params[:cliente][:cliente_pdf_upload][:pdf].nil?
  #       @cliente.upload_files(params[:cliente][:cliente_pdf_upload])
  #       if @cliente.update(resource_params)
  #         if params[:imagens_externas].present?
  #           salva_imagens_externas
  #         end
  #         flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
  #         redirect_to edit_empresa_cliente_path(current_user.empresa, @cliente)
  #       else
  #         send_back_with_error
  #         render :edit
  #       end
  #     else
  #       send_back_with_error
  #       flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: "Cliente") + " É necessário informar um nome para o PDF."
  #       render :edit
  #     end
  #   else
  #     if @cliente.update(resource_params)
  #       if params[:imagens_externas].present?
  #         salva_imagens_externas
  #       end
  #       flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @cliente.class)
  #       redirect_to edit_empresa_cliente_path(current_user.empresa, @cliente)
  #     else
  #       send_back_with_error
  #       render :edit
  #     end
  #   end
  # end

  def destroy
    if @cliente.destroy
      redirect_to empresa_clientes_path(current_user.empresa)
      session[:cliente_id] = nil
    else
      flash[:success] = t("flash.actions.#{__method__}.error", resource_name: @cliente.class)
      redirect_to :back
    end
  end

  private
    def set_pdf_params
      @pdf_params = params[:cliente][:cliente_pdf_upload]
    end

    def set_imagens_externas
      @imagens_externas_params = params[:imagens_externas]
    end
end
