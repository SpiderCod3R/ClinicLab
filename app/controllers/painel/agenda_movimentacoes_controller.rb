'''
  ATENÇÃO!!!
  ZONA DE PERIGO EXTREMO
  CUIDADO AO MANUSEAR ESTA FUNCIONALIDADE
'''
class Painel::AgendaMovimentacoesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :find_empresa
  before_action :find_agenda
  before_action :find_agenda_movimentacao, only: [:edit, :update]
  before_action :set_clientes, only: [:new, :edit]

  # def verify
  #   unless @movimentacao.nil?
  #     render action: :edit
  #   else
      
  #     render action: :new
  #   end
  # end

  def new
    @movimentacao = AgendaMovimentacao.new
  end

  def edit
  end

  def create
    @movimentacao = AgendaMovimentacao.build_movimentacao(params[:agenda_movimentacao])
    @movimentacao.atendente = current_usuario
    if @movimentacao.save
      @movimentacao.change_agenda_status
      flash[:notice] = "Agenda movimentada com sucesso"
      redirect_to painel_empresa_agendas_path(@empresa, @agenda)
    else
      render :new
    end
  end

  def update
    @movimentacao.atendente = current_usuario
    if @movimentacao.update_movimentacao(params[:agenda_movimentacao])
      @movimentacao.change_agenda_status
      flash[:notice] = "Agenda atualizada com sucesso"
      redirect_to painel_empresa_agenda_path(@empresa, @agenda)
    else
      render :edit
    end
  end

  private
    def find_agenda_movimentacao
      @movimentacao = AgendaMovimentacao.find_by(agenda_id: @agenda.id)
    end

    def set_clientes
      @clientes = Cliente.where(empresa_id: @empresa.id)
    end

    def set_convenios
      @convenios = Convenio.where(empresa_id: @empresa.id)
    end

    def find_empresa
      @empresa = Painel::Empresa.friendly.find(params[:empresa_id])
    end

    def find_agenda
      @agenda = Agenda.find_by(empresa_id: @empresa.id, id: params[:agenda_id])
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
