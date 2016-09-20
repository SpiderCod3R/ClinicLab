'''
  ATENÇÃO!!!
  ZONA DE PERIGO EXTREMO
  CUIDADO AO MANUSEAR ESTA FUNCIONALIDADE
'''

class Painel::AgendasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :find_empresa

  respond_to :html, :js, :json, :xml

  def index
    @agendas = Agenda.where(empresa_id: @empresa.id)
  end

  def new
    @agenda = Agenda.new
  end

  def create
    # => Só vai entrar caso os horarios_manha estajam presente nos attributos
    unless params[:horarios][:horarios_manha].nil?
      @agenda_manha = Agenda.create_horarios_manha_by_javascript_params(params)
    end

    # => Só vai entrar caso os horarios_tarde estajam presente nos attributos
    unless params[:horarios][:horarios_tarde].nil?
      @agenda_tarde = Agenda.create_horarios_tarde_by_javascript_params(params)
    end

    respond_to &:json
  end

  private

    def find_empresa
      @empresa = Painel::Empresa.friendly.find(params[:empresa_id])
    end

    def agenda_params
      params.require(:agenda).permit(:id, :empresa_id, :profissional_id,
                                     :data, :atendimento_sabado,
                                     :atendimento_domingo, :atendimento_parcial,
                                     :atendimento_manha_duracao, :atendimento_tarde_duracao,
                                     :atendimento_inicio, :atendimento_final)
    end
end