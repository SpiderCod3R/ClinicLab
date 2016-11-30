class ServicosController < ApplicationController
  load_and_authorize_resource
  before_action :find_empresa

  def index
    @servicos = Servico.where(empresa_id: @empresa.id)
  end

  def show
  end

  def new
    @servico = Servico.new
  end

  def edit
  end

  def create
    @servico = Servico.new(resource_params)
    @servico.addEmpresa= current_usuario.empresa
    if @servico.save
      redirect_to new_empresa_servico_path(@empresa), notice: 'Servico was successfully created.'
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
    def find_empresa
      @empresa = Painel::Empresa.friendly.find(params[:empresa_id])
    end
    def resource_params
      params.require(:servico).permit(:tipo, :abreviatura, :empresa_id)
    end
end
