'''
  ATENÇÃO!!!
  ZONA DE PERIGO EXTREMO
  CUIDADO AO MANUSEAR ESTA FUNCIONALIDADE
'''
class Painel::AgendasController < ApplicationController
  include AgendasHelper
  before_action :authenticate_usuario!
  before_action :find_empresa
  before_action :retorna_referencias_menu_lateral, only: [:index, :search, :search_agenda_medicos]
  before_action :find_agenda, only: [:show,
                                     :movimentar,
                                     :destroy,
                                     :block_day,
                                     :block_period,
                                     :clean,
                                     :didnt_came,
                                     :change_day_or_time,
                                     :change,
                                     :remark_by_pacient,
                                     :remarked_by_pacient,
                                     :remark_by_doctor,
                                     :remarked_by_doctor,
                                     :unmarked_by_doctor,
                                     :unmarked_by_pacient,
                                     :make_appointment,
                                     :attended
                                    ]
  respond_to :html, :js, :json, :xml

  def index
    @search= ransack_params
    @agendas= Agenda.includes(:referencia_agenda).includes(:agenda_movimentacao).
                     da_empresa(@empresa.id).
                     do_dia.
                     order_data.
                     order_atendimento.
                     offset(0).
                     take(12)
    @agenda= Agenda.new
  end

  def search
    @search  = ransack_params
    if params[:q][:agenda_movimentacao_nome_paciente_cont].present?
      @agendas = Agenda.a_partir_da_data(params[:q]).da_empresa(@empresa.id)
    else
      # @agendas = Agenda.da_data(params[:q]).da_empresa(@empresa.id)
    end
    @agenda  = Agenda.new
    render :index
  end

  def load_more_data
    if params[:acao].present?
      @acao = tipo_de_acao(params[:acao])
      case @acao
      when "normal"
        @agendas = Agenda.includes(:referencia_agenda).includes(:agenda_movimentacao).
                          da_empresa(@empresa.id).
                          a_partir_da_data_do_dia.
                          order_data.
                          order_atendimento.
                          offset(params[:offset]).
                          take(params[:page_limit])
      else
        @agendas = Agenda.load_more_medicos({acao: params[:acao],
                                             offset: params[:offset],
                                             page_limit: params[:page_limit],
                                             empresa_id: params[:empresa_id]})
      end
    end
  end

  def search_agenda_medicos
    # @search= ransack_params
    # @agenda  = Agenda.new
    if params
      @referencia = ReferenciaAgenda.find(params[:referencia_agenda_id])
      @agendas  = Agenda.search_agenda_medicos(params)
    end
    respond_to &:js
  end

  def show
    respond_with(@agenda)
  end

  def new
    @agenda = Agenda.new
  end

  def create
    if params[:horarios]
      if params[:horarios][:turno_a][:atendimentos].present?
        Agenda.create_horarios_turno_a_by_javascript_params(params)
      end

      if params[:horarios][:turno_b][:atendimentos].present?
        Agenda.create_horarios_turno_b_by_javascript_params(params)
      end
      @completed = true
    else
      @completed = false
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

  '''
    ACTIONS DAS MOVIMENTACOES
  '''
  def clean
    @current_id = @agenda.agenda_movimentacao.id
    @agenda.clean
    redirect_to :back
  end

  def didnt_came
    @agenda.set_didnt_came
    @changed = true
    respond_to &:js
  end

  def change_day_or_time
    respond_to &:js
  end

  def change
    @agenda_disponivel, @data_valida = @agenda.check_availability(params[:agenda])
    if @agenda_disponivel && @data_valida
      @old_agenda = @agenda
      @new_agenda = @agenda.change_day_or_time(params[:agenda])
      @changed = true
    else
      @changed = false
    end
    respond_to &:js
  end

  def remark_by_pacient
    respond_to &:js
  end

  def remark_by_doctor
    respond_to &:js
  end

  def remarked_by_pacient
    @agenda_disponivel, @data_valida = @agenda.check_availability(params[:agenda])
    if @agenda_disponivel && @data_valida
      @old_agenda = @agenda
      @new_agenda = @agenda.remarked_by_pacient(params[:agenda])
      @changed = true
    else
      @changed = false
    end
    respond_to &:js
  end

  def remarked_by_doctor
    @agenda_disponivel, @data_valida = @agenda.check_availability(params[:agenda])
    if @agenda_disponivel && @data_valida
      @old_agenda = @agenda
      @new_agenda = @agenda.remarked_by_doctor(params[:agenda])
      @changed = true
    else
      @changed = false
    end
    respond_to &:js
  end

  def unmarked_by_doctor
    @agenda.unmarked_by_doctor
    redirect_to :back
  end

  def unmarked_by_pacient
    @agenda.backup_agenda
    @agenda.unmarked_by_pacient
    redirect_to :back
  end

  def make_appointment
    respond_to &:js
  end

  def attended
    @agenda.attended(params[:agenda])
    @changed = true
    respond_to &:js
  end

  private
    def check_params_for_agenda
      lambda do |*args|
        raise ArgumentError if args.empty? || args.size > 2
        arg1, arg2 = args
        return arg1 unless arg1.nil?
        return arg2 unless arg2.nil?
      end
    end

    def find_empresa
      @id = check_params_for_agenda
      @empresa = Painel::Empresa.friendly.find(@id.call(current_usuario.empresa_id, params[:empresa_id]))
    end

    def retorna_referencias_menu_lateral
      @medicos_do_dia= Agenda.retorna_todos_os_medicos_do_dia(@empresa)
      @outros_medicos= Agenda.retorna_todos_os_medicos_com_agenda(@empresa)
    end

    def find_agenda
      @id = check_params_for_agenda
      @agenda = Agenda.find_by(empresa_id: @empresa.id, id: @id.call(params[:id], params[:agenda_id]))
    end

    def ransack_params
      Agenda.ransack(params[:q])
      # if params[:q]
      #   Agenda.a_partir_da_data(params[:q])
      # end
    end

    def ransack_result
      @search.result(distinct: agenda_wants_distinct_results?).da_empresa(@empresa.id).
              order_data.
              order_atendimento
    end
end