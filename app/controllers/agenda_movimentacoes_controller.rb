'''
  ATENÇÃO!!!
  ZONA DE PERIGO EXTREMO
  CUIDADO AO MANUSEAR ESTA FUNCIONALIDADE
'''
class AgendaMovimentacoesController < Support::InsideController
  before_action :find_agenda
  before_action :find_agenda_movimentacao, only: [:edit, :update]
  before_action :set_clientes, only: [:new, :edit]
  before_action :set_convenios, only: [:new, :edit]
  before_action :set_profissionais, only: [:new, :edit]

  def new
    @movimentacao = AgendaMovimentacao.new
  end

  def edit
  end

  def create
    @movimentacao = AgendaMovimentacao.build_movimentacao(params[:agenda_movimentacao])
    @movimentacao.atendente = current_user
    if @movimentacao.save
      @movimentacao.change_agenda_status
      flash[:notice] = "Agenda movimentada com sucesso"
      redirect_to empresa_agendas_path(current_user.empresa)
    else
      render :new
    end
  end

  def update
    @movimentacao.atendente = current_usuario
    if @movimentacao.update_movimentacao(params[:agenda_movimentacao])
      @movimentacao.change_agenda_status
      flash[:notice] = "Agenda atualizada com sucesso"
      redirect_to empresa_agenda_path(current_user.empresa, @agenda)
    else
      render :edit
    end
  end

  private
    def find_agenda
      @agenda = Agenda.find(params[:agenda_id])
    end

    def find_agenda_movimentacao
      @movimentacao = AgendaMovimentacao.find_by(agenda_id: @agenda.id)
    end

    def set_clientes
      @clientes = Cliente.all.order("nome ASC")
    end

    def set_convenios
      @convenios = Convenio.all.order("nome ASC")
    end

    def set_profissionais
      @profissionais = Profissional.all.order("nome ASC")
    end

    def resource_params
      params.require(:agenda_movimantacao).permit(:agenda_id,
                                                  :convenio_id,
                                                  :sem_convenio,
                                                  :obeservacoes,
                                                  :confirmacao,
                                                  :nome_paciente,
                                                  :telefone_paciente,
                                                  :email_paciente,
                                                  :solicitante_id,
                                                  :id_paciente,
                                                  :motivo_bloqueio)
    end
end
