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
    # @movimento_servico = MovimentoServico.new
    @movimento_servico = current_user.empresa.movimento_servicos.build
    if MovimentoServico.last.present?
      @movimento_servico.id = MovimentoServico.last.id + 1
    else
      @movimento_servico.id = 1
    end
    respond_with(@movimento_servico)
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
      redirect_to new_empresa_movimento_servico_path(current_user.empresa)
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
      redirect_to edit_empresa_movimento_servico_servico_path(current_user.empresa, @movimento_servico.id)
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
