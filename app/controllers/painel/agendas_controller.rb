class Painel::AgendasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :find_empresa

  respond_to :html, :js, :json, :xml

  def index
    @agendas = Agenda.where(empresa_id: @empresa.id).order("created_at DESC")
  end

  def new
    @agenda = Agenda.new
    7.times{|x| @agenda.agenda_manha_horarios.build}
    7.times{|x| @agenda.agenda_tarde_horarios.build}
  end

  def create
    @agenda = Agenda.new_by_javascript_params(params[:agenda])
    binding.pry
    @agenda.cria_horarios_turno_manha(params[:agenda][:horarios_manha])
  end

  private

    def find_empresa
      @empresa = Painel::Empresa.friendly.find(params[:empresa_id])
    end

    def agenda_params
      params.require(:agenda).permit(:id, :empresa_id, :profissional_id,
                                     :data_inicial, :data_final, :atendimento_sabado,
                                     :atendimento_domingo, :horario_parcial,
                                     :atendimento_manha_duracao, :atendimento_tarde_duracao,
                                      agenda_manha_horarios_attributes: [ :dia, :turno, :inicio_do_atendimento, 
                                                                 :final_do_atendimento, :agenda_id, :_destroy],
                                      agenda_tarde_horarios_attributes: [ :dia, :turno, :inicio_do_atendimento, 
                                                                 :final_do_atendimento, :agenda_id, :_destroy])
    end
end