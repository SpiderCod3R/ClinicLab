class MovimentoServicosController < Support::InsideController
  load_and_authorize_resource
  before_action :set_movimento_servico, only: [:show, :edit, :update, :destroy]

  # GET /movimento_servicos
  # GET /movimento_servicos.json
  def index
    @movimento_servicos = MovimentoServico.all
  end

  # GET /movimento_servicos/1
  # GET /movimento_servicos/1.json
  def show
  end

  # GET /movimento_servicos/new
  def new
    if params[:cliente_id].present?
      @cliente = Cliente.find(params[:cliente_id])
      if params[:agenda_id].present?
        @agenda = Agenda.find(params[:agenda_id])
        if @agenda.agenda_movimentacao.present?
          @agenda_movimentacao = AgendaMovimentacao.find_by(agenda_id: @agenda.id)
          if @agenda_movimentacao.convenio_id.present?
            @convenio = Convenio.find(@agenda_movimentacao.convenio_id)
          end
          if @agenda_movimentacao.solicitante_id.present?
            @solicitante = Profissional.find(@agenda_movimentacao.solicitante_id)
          end
        end
      end
      @movimento_servico = current_user.empresa.movimento_servicos.build
      if MovimentoServico.last.present?
        @movimento_servico.id = MovimentoServico.last.id + 1
      else
        @movimento_servico.id = 1
      end
      respond_with(@movimento_servico)
    else
      redirect_to :back
      flash[:error] = "É necessário que haja um Paciente relacionado a este agendamento"
    end
  end

  # GET /movimento_servicos/1/edit
  def edit
    session[:movimento_servico_id] = @movimento_servico.id
  end

  # POST /movimento_servicos
  # POST /movimento_servicos.json
  def create
    # @movimento_servico = MovimentoServico.new(movimento_servico_params)
    @movimento_servico = current_user.empresa.movimento_servicos.build(movimento_servico_params)
    if @movimento_servico.save
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @movimento_servico.class)
      redirect_to edit_empresa_movimento_servico_path(current_user.empresa, @movimento_servico.id)
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: @movimento_servico.class)
      render :new
    end
  end

  # PATCH/PUT /movimento_servicos/1
  # PATCH/PUT /movimento_servicos/1.json
  def update
    if @movimento_servico.update(movimento_servico_params)
      flash[:success] = t("flash.actions.#{__method__}.success", resource_name: @movimento_servico.class)
      redirect_to edit_empresa_movimento_servico_path(current_user.empresa, @movimento_servico.id)
    else
      flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: @movimento_servico.class)
      render :edit
    end
  end

  # DELETE /movimento_servicos/1
  # DELETE /movimento_servicos/1.json
  def destroy
    @movimento_servico.destroy
    respond_to do |format|
      format.html { redirect_to movimento_servicos_url, notice: 'Movimento servico was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_servicos
    @movimento_servico = MovimentoServico.find(params[:movimento_servico_id])
    session[:movimento_servico_id] = @movimento_servico.id
  end

  def edit_servicos
    @movimento_servico = MovimentoServico.find(params[:movimento_servico_id])
    session[:movimento_servico_id] = @movimento_servico.id
  end

  def prosseguir_servicos
    @dados_movimento_servico = {}
    unless params.empty?
      if params[:id].present?
        @movimento_servico = MovimentoServico.find(params[:id])
      else
        @movimento_servico = MovimentoServico.new
        if MovimentoServico.last.present?
          @movimento_servico.id = MovimentoServico.last.id + 1
        else
          @movimento_servico.id = 1
        end
      end
      @movimento_servico.empresa_id = current_user.empresa.id
      @movimento_servico.status = params[:status]
      @movimento_servico.cliente_id = params[:cliente_id]
      @movimento_servico.convenio_id = params[:convenio_id]
      @movimento_servico.solicitante_id = params[:solicitante_id]
      @movimento_servico.medico_id = params[:medico_id]
      @movimento_servico.data_entrada = params[:data_entrada]
      @movimento_servico.hora_entrada = params[:hora_entrada]
      @movimento_servico.atendente_id = current_user.id
      @movimento_servico.atualizador_id = current_user.id
      if @movimento_servico.save
        # redirect_to add_servicos_path(current_user.empresa, @movimento_servico.id)
        @dados_movimento_servico = {empresa_id: current_user.empresa.id, movimento_servico_id: @movimento_servico.id}
        respond_to do |format|
          format.html
          format.json { render json: @dados_movimento_servico.as_json }
        end
      else
        flash[:error] = t("flash.actions.#{__method__}.alert", resource_name: @movimento_servico.class)
        redirect_to :back
      end
    end
  end

  def retorna_servico
    unless params[:servico_id].empty?
      @servico = Servico.find_by(empresa_id: current_user.empresa.id, id: params[:servico_id])
      @valor_servico = @servico.valor
      respond_to do |format|
        format.html
        format.json { render json: @valor_servico.as_json }
      end
    end
  end

  def salva_movimento_servico_servicos
    @movimento_servico = MovimentoServico.find(session[:movimento_servico_id])
    if params[:servicos_attributes]
      dados = JSON.parse(params[:servicos_attributes].to_json)
      dados.each do |_key, array |
        @movimento_servico_servico = MovimentoServicoServico.new(servico_id: array["servico_id"],
                                                                 movimento_servico_id: @movimento_servico.id,
                                                                 valor_servico: array["servico_valor"],
                                                                 empresa_id: current_user.empresa.id)
        @movimento_servico_servico.save!
      end
    end
  end

  def destroy_movimento_servico_servico
    @movimento_servico_servico = MovimentoServicoServico.find(params[:movimento_servico_servico_id])
    @movimento_servico_servico.destroy!
    respond_to &:js
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movimento_servico
      @movimento_servico = MovimentoServico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movimento_servico_params
      params.require(:movimento_servico).permit(:id,
                                                :atendente_id,
                                                :atualizador_id,
                                                :cliente_id,
                                                :convenio_id,
                                                :solicitante_id,
                                                :medico_id,
                                                :data_entrada,
                                                :hora_entrada,
                                                :valor_total,
                                                :empresa_id,
                                                :created_at,
                                                :updated_at,
                                                :status,
                                                :valor_desconto,
                                                movimento_servico_servicos_attributes: [:id, :servico_id, :movimento_servico_id, :valor_servico, :empresa_id])
    end
end
