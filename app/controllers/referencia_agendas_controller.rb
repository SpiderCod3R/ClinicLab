class ReferenciaAgendasController < Support::InsideController
  before_action :find_referencia, only: [:show, :edit, :update, :destroy]

  def index
    if params[:status] || params[:descricao] || params[:profissional]
      @referencias = ReferenciaAgenda.where(empresa: current_user.empresa).search(params[:status]["status"], params[:descricao], params[:profissional]['id']).order("created_at DESC").page(params[:page]).per(10)
    else
      @referencias = ReferenciaAgenda.where(empresa: current_user.empresa).order("created_at DESC").page(params[:page]).per(10)
      respond_with(@referencias)
    end
  end

  def show
  end

  def new
    @referencia = current_user.empresa.referencia_agendas.build
  end

  def create
    @referencia = current_user.empresa.referencia_agendas.build(resource_params)
    if @referencia.save
      flash[:notice] = t('agendas.messages.referency_saved')
      redirect_to :back
    else
      render :new
    end
  end


  private
    def find_referencia
      @referencia = ReferenciaAgenda.localize(params[:id], @empresa)
    end

    def resource_params
      params.require(:referencia_agenda).permit(:empresa_id, :profissional_id, :descricao, :status)
    end
end
