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
    @agendas = Agenda.where(empresa_id: @empresa.id).page params[:page]
  end

  def new
    @agenda = Agenda.new
  end

  def create
    # => Só vai entrar caso os horarios_turno_a estajam presente nos attributos
    unless params[:horarios][:turno_a][:horarios_turno_a].nil?
      @agenda_manha = Agenda.create_horarios_turno_a_by_javascript_params(params)
    end

    # => Só vai entrar caso os horarios_turno_b estajam presente nos attributos
    unless params[:horarios][:turno_b][:horarios_turno_b].nil?
      @agenda_tarde = Agenda.create_horarios_turno_b_by_javascript_params(params)
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
                                     :atendimento_duracao,
                                     :atendimento_inicio, :atendimento_final)
    end
end