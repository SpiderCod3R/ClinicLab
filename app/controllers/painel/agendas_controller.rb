'''
  ATENÇÃO!!!
  ZONA DE PERIGO EXTREMO
  CUIDADO AO MANUSEAR ESTA FUNCIONALIDADE
'''
require 'custom/agenda_notification'
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
    @agenda_notification = AgendaNotification.new(params)
    @invalid_fields_for_shift_a = @agenda_notification.validate_shift_a!
    @invalid_fields_for_shift_b = @agenda_notification.validate_shift_b!

    if @invalid_fields_for_shift_a.nil?
      @agenda_manha = Agenda.create_horarios_turno_a_by_javascript_params(params)
    end

    if @invalid_fields_for_shift_b.nil?
      @agenda_tarde = Agenda.create_horarios_turno_b_by_javascript_params(params)
    end
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