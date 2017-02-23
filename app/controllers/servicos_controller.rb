class ServicosController < Support::InsideController
  load_and_authorize_resource

  def index
    @search = Servico.where(empresa: current_user.empresa).ransack(params[:q])
    @servicos = @search.result.order("id desc").page(params[:page]).per(10)
    @search.build_condition if @search.conditions.empty?
  end

  def show
  end

  def new
    @servico = current_user.empresa.servicos.build
  end

  def edit
  end

  def create
    @servico = current_user.empresa.servicos.build(resource_params)
    if @servico.save
      redirect_to new_empresa_servico_path(current_user.empresa), notice: 'Servico was successfully created.'
    else
      render :new
    end
  end

  def update
    if @servico.update(resource_params)
      redirect_to empresa_servicos_path(@empresa), notice: 'Servico was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @servico.destroy
    redirect_to :back, notice: 'Servico was successfully destroyed.'
  end

  private
    def resource_params
      params.require(:servico).permit(:tipo, :abreviatura, :empresa_id)
    end
end
