class ReferenciaAgendasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :find_empresa
  before_action :find_referencia, only: [:show, :edit, :update, :destroy]

  def index
    @referencias = ReferenciaAgenda.where(empresa_id: @empresa.id).page(params[:page])
  end

  def show
  end

  def new
    @referencia = ReferenciaAgenda.new
  end

  def create
    @referencia = ReferenciaAgenda.new(resource_params)
    @referencia.empresa_id = @empresa.id
    if @referencia.save
      flash[:notice] = t('agendas.messages.referency_saved')
      redirect_to :back
    else
      render :new
    end
  end


  private
    def find_empresa
      @empresa = Painel::Empresa.friendly.find(current_usuario.empresa_id)
    end

    def find_referencia
      @referencia = ReferenciaAgenda.localize(params[:id], @empresa)
    end

    def resource_params
      params.require(:referencia_agenda).permit(:empresa_id, :profissional_id, :descricao, :status)
    end
end
