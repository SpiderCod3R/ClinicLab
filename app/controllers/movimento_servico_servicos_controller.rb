class MovimentoServicoServicosController < Support::InsideController
  # before_action :set_movimento_servico_servico, only: [:show, :edit, :update, :destroy]

  # GET /movimento_servico_servicos
  # GET /movimento_servico_servicos.json
  def index
    @movimento_servico_servicos = MovimentoServicoServico.all
  end

  # GET /movimento_servico_servicos/1
  # GET /movimento_servico_servicos/1.json
  def show
  end

  # GET /movimento_servico_servicos/new
  def new
    @movimento_servico_servico = MovimentoServicoServico.new
  end

  # GET /movimento_servico_servicos/1/edit
  def edit
  end

  # POST /movimento_servico_servicos
  # POST /movimento_servico_servicos.json
  def create
    @movimento_servico_servico = MovimentoServicoServico.new(movimento_servico_servico_params)

    respond_to do |format|
      if @movimento_servico_servico.save
        format.html { redirect_to @movimento_servico_servico, notice: 'Movimento servico servico was successfully created.' }
        format.json { render :show, status: :created, location: @movimento_servico_servico }
      else
        format.html { render :new }
        format.json { render json: @movimento_servico_servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movimento_servico_servicos/1
  # PATCH/PUT /movimento_servico_servicos/1.json
  def update
    respond_to do |format|
      if @movimento_servico_servico.update(movimento_servico_servico_params)
        format.html { redirect_to @movimento_servico_servico, notice: 'Movimento servico servico was successfully updated.' }
        format.json { render :show, status: :ok, location: @movimento_servico_servico }
      else
        format.html { render :edit }
        format.json { render json: @movimento_servico_servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movimento_servico_servicos/1
  # DELETE /movimento_servico_servicos/1.json
  def destroy
    @movimento_servico_servico.destroy
    respond_to do |format|
      format.html { redirect_to movimento_servico_servicos_url, notice: 'Movimento servico servico was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movimento_servico_servico
      @movimento_servico_servico = MovimentoServicoServico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movimento_servico_servico_params
      params.fetch(:movimento_servico_servico, {})
    end
end
