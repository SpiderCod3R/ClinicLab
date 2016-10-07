'''
  ATENÇÃO!!!
  ZONA DE PERIGO EXTREMO
  CUIDADO AO MANUSEAR ESTA FUNCIONALIDADE
'''
require 'custom/agenda_notification'
class Painel::AgendasController < ApplicationController
  include AgendasHelper
  before_action :authenticate_usuario!
  before_action :find_empresa
  before_action :find_agenda, only: [:show, :movimentar, :destroy]

  respond_to :html, :js, :json, :xml

  def index
    @search  = ransack_params
    @search.build_sort if @search.sorts.empty?
    @agendas = ransack_result
  end

  def advanced_search
    index
    render :index
  end

  def show
    respond_with(@agenda)
  end

  def new
    @agenda = Agenda.new
  end

  def create
    # @agenda_notification = AgendaNotification.new(params)
    # @invalid_fields_for_shift_a = @agenda_notification.validate_shift_a!
    # @invalid_fields_for_shift_b = @agenda_notification.validate_shift_b!

    if params[:horarios][:turno_a][:atendimentos].present?
      @agenda_manha = Agenda.create_horarios_turno_a_by_javascript_params(params)
    end

    if params[:horarios][:turno_b][:atendimentos].present?
      @agenda_tarde = Agenda.create_horarios_turno_b_by_javascript_params(params)
    end
  end

  def destroy
    if @agenda.destroy
      flash[:warning] = "A agenda foi deletada."
      redirect_to painel_empresa_agendas_path(@empresa)
    else
      flash[:error] = "A agenda não pôde ser deletada."
      respond_with(@agenda)
    end
  end

  private
    def find_empresa
      @empresa = Painel::Empresa.friendly.find(params[:empresa_id])
    end

    def find_agenda
      @agenda = Agenda.find_by(empresa_id: @empresa.id, id: params[:agenda_id])
    end

    def ransack_params
      Agenda.includes(:profissional).ransack(params[:q])
    end

    def ransack_result
      @search.result(distinct: agenda_wants_distinct_results?).where(empresa_id: @empresa.id).page(params[:page])
    end
end