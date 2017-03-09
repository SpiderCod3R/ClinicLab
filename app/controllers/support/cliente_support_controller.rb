class Support::ClienteSupportController < Support::InsideController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy, :destroy_pdf]
  before_action :set_estados, only: [:new, :edit, :create, :update, :ficha, :clinic_sheet]
  before_action :set_access, only: [:edit, :ficha, :clinic_sheet]

  def clinic_sheet
    session[:agenda_id] = params[:agenda_id]
    @agenda = Agenda.find(session[:agenda_id])
    if params[:cliente_id]
      @cliente = current_user.empresa.clientes.find(params[:cliente_id])
      session[:cliente_id] = @cliente.id
    end

    @cliente = current_user.empresa.clientes.build unless params[:cliente_id].present?
    load_tabs if @cliente.id?

    if params[:sala_espera_id].present?
      session[:sala_espera_id] = params[:sala_espera_id]
      @sala_espera=@agenda.sala_de_esperas.find(params[:sala_espera_id])
      @sala_espera.hora_inicio_atendimento= DateTime.now
      @sala_espera.save
    end
  end

  def paginate_pdfs
    @cliente_collection_pdfs = ClientePdfUpload.where(cliente_id: params[:id]).ultima_data.page(params[:page]).per(10)
  end

  def change_or_create_paciente
    @agenda = Agenda.find(session[:agenda_id])
    if params[:cliente][:id].present?
      @cliente = Cliente.find(params[:cliente][:id])
      @cliente.upload_files(params[:cliente][:cliente_pdf_upload]) if !params[:cliente][:cliente_pdf_upload].nil?
      if @cliente.update_data(params[:cliente])
        @agenda.agenda_movimentacao.update_attributes(nome_paciente: @cliente.nome, telefone_paciente: @cliente.telefone,
                                                      email_paciente: @cliente.email, cliente_id: @cliente.id)
        if session[:sala_espera_id].present?
          redirect_to :back
        end
      end
      flash[:notice] = "Dados do cliente atualizados com sucesso."
      redirect_to empresa_clinic_sheet_cliente_path(current_user.empresa, cliente_id: @cliente.id, agenda_id: @agenda.id)
    else
      @cliente = current_user.empresa.clientes.build(resource_params)
      if @cliente.save
        @agenda.agenda_movimentacao.update_attributes(nome_paciente: @cliente.nome, telefone_paciente: @cliente.telefone,
                                                      email_paciente: @cliente.email, cliente_id: @cliente.id)
        flash[:notice] = "Dados do cliente salvos com sucesso."
        redirect_to empresa_clinic_sheet_cliente_path(current_user.empresa, cliente_id: @cliente.id, agenda_id: @agenda.id)
      else
        load_tabs if @cliente.id?
        render :clinic_sheet
      end
    end
  end

  def find_textos_livre
    @cliente = Cliente.find(params[:cliente_id])
    @cliente_texto_livre = @cliente.cliente_texto_livres.find(params[:texto_livre_id]) if params[:texto_livre_id].present?
    if params[:first_page].present?
      @cliente_texto_livre = @cliente.cliente_texto_livres.first
    elsif params[:previous_page].present?
      @cliente_texto_livre = @cliente_texto_livre.previous
    elsif params[:next_page].present?
      @cliente_texto_livre = @cliente_texto_livre.next
    elsif params[:last_page].present?
      @cliente_texto_livre = @cliente.cliente_texto_livres.last
    end
    respond_to &:js
  end

  def find_recipe
    @cliente = Cliente.find(params[:id])
    @cliente_receituario = @cliente.cliente_receituarios.find(params[:cliente_receituario_id]) if params[:cliente_receituario_id].present?
    if params[:first_page].present?
      @cliente_receituario = @cliente.cliente_receituarios.first
    elsif params[:previous_page].present?
      @cliente_receituario = @cliente_receituario.previous
    elsif params[:next_page].present?
      @cliente_receituario = @cliente_receituario.next
    elsif params[:last_page].present?
      @cliente_receituario = @cliente.cliente_receituarios.last
    end
    respond_to &:js
  end

  def print_free_text
    @cliente = Cliente.find(params[:id])
    @cliente_texto_livre = @cliente.cliente_texto_livres.find(params[:texto_livre_id]) if params[:texto_livre_id].present?
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PrintFreeText.new(@cliente_texto_livre.content_data)
        send_data pdf.render, filename: "#{@cliente_texto_livre.texto_livre.nome}", type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def print_historico
    get_historicos
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PrintHistoricoIndividual.new(@historicos.first)
        send_data pdf.render, filename: "historico", type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def print_historico_full
    get_historicos
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PrintHistoricoCompleto.new(@historicos)
        send_data pdf.render, filename: "historico", type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def destroy_pdf
    @cliente_pdf_id = params[:pdf]
    @cliente_pdf = @cliente.cliente_pdf_uploads.find(params[:pdf])
    @cliente_pdf.destroy
    respond_to &:js
  end

  def retorna_historico
    unless params[:historico_id].empty?
      set_historico
      @dados_historico = {}
      @dados_historico[:data] = I18n.l(@historico.updated_at, format: :long)
      @dados_historico[:usuario] = @historico.user.name
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
      @historico.user = current_user
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

  def destroy_cliente_receituario
    @cliente = Cliente.find(params[:cliente_id])
    @cliente_receituario = @cliente.cliente_receituarios.find(params[:recipe_id])
    @cliente_receituario.destroy
    respond_to do |format|
      format.html
      format.json { render json: session[:cliente_id].as_json }
    end
  end

  def salva_cliente_convenios
    @cliente = Cliente.find(session[:cliente_id])
    if params[:convenios_attributes]
      dados = JSON.parse(params[:convenios_attributes].to_json)
      dados.each do |_key, array |
        @cliente_convenio = ClienteConvenio.new(convenio_id: array["convenio_id"],
                                                status_convenio: array["status_convenio"],
                                                validade_carteira: array["validade_carteira"],
                                                matricula: array["matricula"],
                                                produto: array["produto"],
                                                titular: array["titular"],
                                                plano: array["plano"],
                                                cliente_id: @cliente.id)
        @cliente_convenio.save!
      end
    end
  end

  def destroy_cliente_convenio
    @cliente_convenio = ClienteConvenio.find(params[:cliente_convenio_id])
    @cliente_convenio.destroy!
    respond_to &:js
  end

  def include_recipe
    if params[:cliente]
      @cliente = Cliente.find(params[:cliente][:id])
    end

    if params[:cliente][:cliente_recipe][:id].to_i.eql?(0)
      @cliente_receituario = @cliente.cliente_receituarios.build(user_id: current_user.id, content: params[:cliente][:cliente_recipe][:content])
      @cliente_receituario.save
    else
      @cliente_receituario = @cliente.cliente_receituarios.find(params[:cliente][:cliente_recipe][:id])
      @cliente_receituario.update_attributes(content: params[:cliente][:cliente_recipe][:content], user_id: current_user.id)
    end

    respond_to do |format|
      format.html
      format.json { render json: session[:cliente_id].as_json }
    end
  end

  private
    def set_access
      if !current_user.admin?
        @model = Gclinic::Model.find_by(model_class: "Cliente")
        @user_model = current_user.user_models.find_by(model_id: @model.id)
        @cliente_permissao = ClientePermissao.find_by user_model_id: @user_model.id
      end
    end

    def load_tabs
      @cliente_texto_livre = @cliente.cliente_texto_livres.first
      @cliente_receituario = @cliente.cliente_receituarios.first
      @cliente_collection_pdfs  = @cliente.cliente_pdf_uploads.ultima_data.page params[:page]
      @texto_livres = current_user.empresa.texto_livres.page params[:page]
      @cliente_receituarios = @cliente.cliente_receituarios.page params[:page]
      if !@cliente.cliente_pdf_uploads.empty?
        @cliente_pdf_uploads = @cliente.cliente_pdf_uploads.build
      else
        @cliente_pdf_uploads = @cliente.cliente_pdf_uploads.build
      end
      get_historicos
    end

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

    def resource_params
      params.require(:cliente).permit(
        :id, :status, :nome, :cpf, :endereco, :complemento, :bairro, :estado_id,
        :cidade_id, :empresa_id, :foto, :email, :telefone, :cargo_id,
        :nascimento, :sexo, :rg, :estado_civil, :nacionalidade, :naturalidade, 
        cliente_convenios_attributes: [:id, :cliente_id, :convenio_id, :status_convenio, :matricula, :plano, :validade_carteira, :produto, :titular],
        cliente_pdf_upload_attributes: [:id, :cliente_id, :anotacoes, :data, :pdf, :_destroy])
    end
end