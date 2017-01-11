class Support::ClienteSupportController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_cliente, only: [:show, :edit, :update, :destroy, :destroy_pdf]
  before_action :set_estados, only: [:new, :edit, :create, :update, :ficha, :ficha_em_branco]
  respond_to :docx

  def ficha
    session[:agenda_id] = params[:agenda_id]
    @cliente = current_usuario.empresa.clientes.build
    render :ficha_em_branco
  end

  def ficha_em_branco
    #only_partial
  end

  def change_or_create_new_paciente
    @agenda = Agenda.find(session[:agenda_id])

    if params[:cliente][:id].present?
      @cliente = Cliente.find(params[:cliente][:id])
      @cliente.update_data(params[:cliente])
    else
      @cliente = current_usuario.empresa.clientes.build(resource_params)
      @cliente.save
    end

    @agenda.agenda_movimentacao.update_attributes(nome_paciente: @cliente.nome,
                                                  telefone_paciente: @cliente.telefone,
                                                  email_paciente: @cliente.email,
                                                  convenio_id: @cliente.convenio_id
                                                  )
    redirect_to painel_empresa_agenda_path(current_usuario.empresa, @agenda)
  end

  '''
    Action para paginar textos livre dentro do cliente
  '''
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

    def resource_params
      params.require(:cliente).permit(
        :id, :status, :nome, :cpf, :endereco, :complemento, :bairro, :estado_id,
        :cidade_id, :empresa_id, :foto, :email, :telefone, :cargo_id, :status_convenio,
        :matricula, :plano, :validade_carteira, :produto, :titular, :convenio_id, :nascimento,
        :sexo, :rg, :estado_civil, :nacionalidade, :naturalidade,
        cliente_pdf_upload_attributes: [:id, :cliente_id, :anotacoes, :data, :pdf, :_destroy])
    end
end