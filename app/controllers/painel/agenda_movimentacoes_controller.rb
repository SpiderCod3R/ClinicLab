'''
  ATENÇÃO!!!
  ZONA DE PERIGO EXTREMO
  CUIDADO AO MANUSEAR ESTA FUNCIONALIDADE
'''
class Painel::AgendaMovimentacoesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :find_empresa
  before_action :find_agenda
  before_action :set_clientes, :set_convenios, only: [:new]

  def new
    @nova_movimentacao = AgendaMovimentacao.new
    respond_to &:js
  end

  def create
    
  end

  private
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
      params.require(:agenda_movimantacao).permit(:agenda_id, :convenio_id, :sem_convenio, :obeservacoes, :confirmacao)
    end
end
