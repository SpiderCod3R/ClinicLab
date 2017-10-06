class Support::ClienteSupportController < Support::InsideController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy, :destroy_pdf]
  before_action :set_estados, only: [:new, :edit, :create, :update, :ficha, :clinic_sheet]
  before_action :set_access, only: [:edit, :ficha, :clinic_sheet]

  def clinic_sheet
    session[:convenios_attributes] = nil
    session[:agenda_id] = params[:agenda_id]
    @agenda = Agenda.find(session[:agenda_id])
    if params[:cliente_id]
      @cliente = Cliente.find(params[:cliente_id])
      session[:cliente_id] = @cliente.id
    else
      @cliente = current_user.empresa.clientes.build
    end

    load_tabs if @cliente.id?

    # => Entrará nesse contexto se e somente si a ficha do paciente
    # estiver vindo da agenda no que diz respeito a sala de espera
    load_waiting_room
  end

  def paginate_pdfs
    @cliente_collection_pdfs = ClientePdfUpload.where(cliente_id: params[:id]).ultima_data.page(params[:page]).per(10)
  end

  def cria_session_cliente_convenios
    if params[:convenios_attributes]
      session[:convenios_attributes]=params[:convenios_attributes]
      # session[:option_for_cliente_convenio]=params[:option]
    end
  end

  def change_or_create_cliente
    @agenda = Agenda.find(session[:agenda_id])
    # => Caso o Cliente já exista esse primeiro if é executado
    if params[:cliente][:id].present?
      @cliente = Cliente.find(params[:cliente][:id])
      @cliente.collect_agenda_movimentacao_fields(@agenda)
      @cliente.manage_convenios(session[:convenios_attributes]) if !session[:convenios_attributes].nil?

      if !params[:cliente][:cliente_pdf_upload].nil?
        if params[:cliente][:cliente_pdf_upload][:anotacoes] != "" and params[:cliente][:cliente_pdf_upload][:pdf] != ""
          @cliente.upload_files(params[:cliente][:cliente_pdf_upload])
        end
      end

      if @cliente.update(resource_params)
        @agenda.agenda_movimentacao.update_attributes(nome_paciente: @cliente.nome, telefone_paciente: @cliente.telefone,
                                                      email_paciente: @cliente.email, cliente_id: @cliente.id)
        if params[:imagens_externas].present?
          salva_imagens_externas
        end
        flash[:notice] = "Dados do cliente atualizados com sucesso."
        redirect_to empresa_clinic_sheet_cliente_path(current_user.empresa, cliente_id: @cliente.id, agenda_id: @agenda.id) and return
      else
        if params[:page].present?
          send_back_with_error
        else
          load_tabs
        end
        render :clinic_sheet
      end
    else
      @cliente = current_user.empresa.clientes.build(resource_params)
      @cliente.collect_agenda_movimentacao_fields(@agenda)
      if @cliente.save
        @cliente.manage_convenios(session[:convenios_attributes]) if !session[:convenios_attributes].nil?
        @agenda.agenda_movimentacao.update_attributes(nome_paciente: @cliente.nome, telefone_paciente: @cliente.telefone,
                                                      email_paciente: @cliente.email, cliente_id: @cliente.id)
        flash[:notice] = "Dados do cliente salvos com sucesso."
        redirect_to empresa_clinic_sheet_cliente_path(current_user.empresa, cliente_id: @cliente.id, agenda_id: @agenda.id)
      else
        if params[:page].present?
          send_back_with_error
        else
          load_tabs
        end
        render :clinic_sheet
      end
    end
  end

  def find_textos_livre
    @cliente = Cliente.find(params[:cliente_id])
    @cliente_texto_livre = @cliente.cliente_texto_livres.find(params[:texto_livre_id]) if params[:texto_livre_id].present?
    if params[:first_page].present?
      @cliente_texto_livre = @cliente.cliente_texto_livres.last
    elsif params[:previous_page].present?
      @cliente_texto_livre = @cliente_texto_livre.previous
    elsif params[:next_page].present?
      @cliente_texto_livre = @cliente_texto_livre.next
    elsif params[:last_page].present?
      @cliente_texto_livre = @cliente.cliente_texto_livres.first
    end
    respond_to &:js
  end

  def find_recipe
    @cliente = Cliente.find(params[:id])
    @cliente_receituario = @cliente.cliente_receituarios.find(params[:cliente_receituario_id]) if params[:cliente_receituario_id].present?
    if params[:first_page].present?
      @cliente_receituario = @cliente.cliente_receituarios.last
    elsif params[:previous_page].present?
      @cliente_receituario = @cliente_receituario.previous
    elsif params[:next_page].present?
      @cliente_receituario = @cliente_receituario.next
    elsif params[:last_page].present?
      @cliente_receituario = @cliente.cliente_receituarios.first
    end
    respond_to &:js
  end

  def print_sadt
    @cliente = Cliente.find(params[:id])
    @sadt = @cliente.sadts.find(params[:sadt_id]) if params[:sadt_id].present?
    @sadt_exame_procedimentos = SadtExameProcedimento.where(sadt_id: @sadt.id)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PrintSadt.new(@cliente, @sadt, @sadt_exame_procedimentos)
        send_data pdf.render, filename: "#{@cliente.nome}", type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def print_recipe
    @relatorio = ConfiguracaoRelatorio.find_by(empresa_id: current_user.empresa.id)
    unless @relatorio.nil?
      @cliente = Cliente.find(params[:id])
      @cliente_receituario = @cliente.cliente_receituarios.find(params[:receituario_id]) if params[:receituario_id].present?
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PrintRecipe.new(@cliente, @cliente_receituario.content, @relatorio)
          send_data pdf.render, filename: "#{@cliente_receituario.cliente.nome}", type: 'application/pdf', disposition: 'inline'
        end
      end
    else
      flash[:error] = "É necessário que haja uma Configuração de Relatório cadastrada."
      redirect_to :back
    end
  end

  def print_free_text
    @relatorio = ConfiguracaoRelatorio.find_by(empresa_id: current_user.empresa.id)
    unless @relatorio.nil?
      @cliente = Cliente.find(params[:id])
      @cliente_texto_livre = @cliente.cliente_texto_livres.find(params[:texto_livre_id]) if params[:texto_livre_id].present?
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PrintFreeText.new(@cliente, @cliente_texto_livre.content_data, @relatorio)
          send_data pdf.render, filename: "Texto_Livre", type: 'application/pdf', disposition: 'inline'
        end
      end
    else
      flash[:error] = "É necessário que haja uma Configuração de Relatório cadastrada."
      redirect_to :back
    end
  end


  def print_historico
    @relatorio = ConfiguracaoRelatorio.find_by(empresa_id: current_user.empresa.id)
    unless @relatorio.nil?
      get_historicos
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PrintHistoricoIndividual.new(@historicos.first, @relatorio, "Histórico Individual")
          send_data pdf.render, filename: "historico", type: 'application/pdf', disposition: 'inline'
        end
      end
    else
      flash[:error] = "É necessário que haja uma Configuração de Relatório cadastrada."
      redirect_to :back
    end
  end

  def print_historico_full
    @relatorio = ConfiguracaoRelatorio.find_by(empresa_id: current_user.empresa.id)
    unless @relatorio.nil?
      get_historicos
      respond_to do |format|
        format.html
        format.pdf do
          pdf = PrintHistoricoCompleto.new(@historicos, @relatorio, "Históricos")
          send_data pdf.render, filename: "historico", type: 'application/pdf', disposition: 'inline'
        end
      end
    else
      flash[:error] = "É necessário que haja uma Configuração de Relatório cadastrada."
      redirect_to :back
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
      @cliente_texto_livre = ClienteTextoLivre.include(params[:cliente_texto_livre])
    else
      @cliente_texto_livre = ClienteTextoLivre.find(params[:cliente_texto_livre][:id])
      @cliente_texto_livre.update_content(params[:cliente_texto_livre])
    end

    respond_to do |format|
      format.html
      format.json { render json: session[:cliente_id].as_json }
    end
  end

  def salvar_imprimir_texto_livre
    if params[:cliente_texto_livre][:id].to_i.eql?(0)
      @cliente_texto_livre = ClienteTextoLivre.include(params[:cliente_texto_livre])
      if @cliente_texto_livre
        respond_to do |format|
          format.html
          format.json { render json: @cliente_texto_livre.as_json }
        end
      end
    else
      @cliente_texto_livre = ClienteTextoLivre.find(params[:cliente_texto_livre][:id])
      if @cliente_texto_livre.update_content(params[:cliente_texto_livre])
        respond_to do |format|
          format.html
          format.json { render json: @cliente_texto_livre.as_json }
        end
      end
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

    if params[:agenda][:id] != ""
      @agenda = Agenda.find(params[:agenda][:id])
    end

    # respond_to do |format|
    #   format.html
    #   format.json { render json: session[:cliente_id].as_json }
    # end
  end

  def search_pdf_remotely
    @cliente = Cliente.find(params[:cliente][:id])
    @cliente_collection_pdfs = @cliente.cliente_pdf_uploads.search(params[:search])
    respond_to &:json
  end

  def search_sadt_remotely
    @cliente_collection_sadts = Sadt.where(cliente_id: params[:cliente][:id])
    if params[:search][:indicacao_clinica].present?
      @cliente_collection_sadts = @cliente_collection_sadts.where("indicacao_clinica LIKE ?","#{params[:search][:indicacao_clinica]}%")
    end
    if params[:search][:data].present?
      @data_sadt = I18n.l(Date.parse(params[:search][:data]), format: :english)
      @cliente_collection_sadts = @cliente_collection_sadts.where(data: @data_sadt)
    end
    respond_to do |format|
      format.html
      format.json { render json: @cliente_collection_sadts.as_json }
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

    def load_waiting_room
      if params[:sala_espera_id].present?
        session[:sala_espera_id] = params[:sala_espera_id]
        @sala_espera=@agenda.sala_de_esperas.find(params[:sala_espera_id])
        if @sala_espera.hora_inicio_atendimento.nil?
          @sala_espera.hora_inicio_atendimento= DateTime.now
          @sala_espera.save
        end
      end
    end

    def load_tabs
      @cliente_texto_livre = @cliente.cliente_texto_livres.last
      @cliente_receituario = @cliente.cliente_receituarios.last
      @cliente_collection_pdfs  = @cliente.cliente_pdf_uploads.ultima_data.page params[:page]
      # @texto_livres = current_user.empresa.texto_livres.page params[:page]
      # @cliente_receituarios = @cliente.cliente_receituarios.page params[:page]
      if !@cliente.cliente_pdf_uploads.empty?
        @cliente_pdf_uploads = @cliente.cliente_pdf_uploads.build
      else
        @cliente_pdf_uploads = @cliente.cliente_pdf_uploads.build
      end
      get_historicos
      @cliente.imagens_externas.build
      @sadt = @cliente.sadts.build
      @sadt_exame_procedimento = @sadt.sadt_exame_procedimentos.build
      @cliente_collection_sadts = @cliente.sadts.page params[:page]
    end

    def send_back_with_error
      @cliente_texto_livre=@cliente.cliente_texto_livres.first
      # @cliente_pdf_uploads=@cliente.cliente_pdf_uploads.build
      @cliente.imagens_externas.build
      if params[:page].permitted?
        @@page = params[:page]
      else
        @@page = 7
      end
      @cliente_collection_pdfs = @cliente.cliente_pdf_uploads.ultima_data.page(@@page).per(2)
      @cliente_receituarios = @cliente.cliente_receituarios.page(@@page).per(2)
      @texto_livres = current_user.empresa.texto_livres.page(@@page).per(2)
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
        :id, :status, :nome, :cpf, :endereco, :complemento, :bairro, :estado_id, :indicacao, :observacoes,
        :cidade_id, :empresa_id, :foto, :email, :telefone, :cargo_id, :pai, :mae, :cep,
        :nascimento, :sexo, :rg, :estado_civil, :nacionalidade, :naturalidade, :altura, :peso,
        cliente_convenios_attributes: [:id, :cliente_id, :convenio_id, :status_convenio, :matricula, :plano, :validade_carteira, :produto, :titular],
        imagens_externas_attributes: [:foto_antes, :foto_depois, :cliente_id],
        cliente_pdf_upload_attributes: [:id, :cliente_id, :anotacoes, :data, :pdf, :_destroy],
        sadts_attributes: [:indicacao_clinica, :data, :cliente_id, :empresa_id, :_destroy],
        sadt_exame_procedimentos_attributes: [:sadt_id, :exame_procedimento_id, :empresa_id, :_destroy])
    end
end
