'''
  ATENÇÃO!!!
  ZONA DE PERIGO EXTREMO
  CUIDADO AO MANUSEAR ESTA FUNCIONALIDADE
'''
class Support::AgendaSupportController < Support::InsideController
  include AgendasHelper
  before_action :set_agenda_movimentacoes
  before_action :set_referencia_agendas
  before_action :verify_agenda_authorization
  before_action :retorna_referencias_menu_lateral

  def search
    if nome_do_paciente_presente?
      @agendas = Agenda.paciente_a_partir_da_data(params[:q])
    end

    if referencia_agenda_presente?
      @content = ReferenciaAgenda.find(params[:q][:referencia_agenda_id]).id
      @content = I18n.t('agendas.helpers.by_parameters', parameter: @content)
      @agendas = Agenda.pela_referencia_da_data(params[:q])
    end

    if referencia_agenda_e_paciente_presentes?
      @content = ReferenciaAgenda.find(params[:q][:referencia_agenda_id]).id
      @content = I18n.t('agendas.helpers.by_parameters', parameter: @content)
      @agendas = Agenda.pela_referencia_e_paciente_da_data(params[:q])
    end

    if somente_data_presente?
      @content = I18n.t('agendas.helpers.search_by_day_content')
      @agendas = Agenda.da_data(params[:q])
    end

    respond_to &:js
  end

  def load_more_data
    if params[:acao].present?
      @acao = tipo_de_acao(params[:acao])
      case @acao
      when I18n.t('agendas.helpers.default')
        @agendas = Agenda.default(params)
      when I18n.t('agendas.helpers.by_day')
        @agendas = Agenda.search_by_day(params)
      else
        @agendas = Agenda.load_more_medicos({acao: params[:acao],
                                             offset: params[:offset],
                                             page_limit: params[:page_limit],
                                             empresa_id: params[:empresa_id]})
      end
    end

    # => Carrega as permissoes da agenda
    if !current_user.admin?
      @model = Gclinic::Model.find_by(model_class: "Agenda")
      @user_model = current_user.user_models.find_by(model_id: @model.id)
      @agenda_permissao = AgendaPermissao.find_by user_model_id: @user_model.id
    end
  end

  def search_agenda_medicos
    if params
      @referencia = ReferenciaAgenda.find(params[:referencia_agenda_id])
      @agendas  = Agenda.search_agenda_medicos(params)
    end
    respond_to &:js
  end

  def search_agenda_medicos_outro_dia
    if params
      @referencia = ReferenciaAgenda.find(params[:referencia_agenda_id])
      @agendas  = Agenda.search_agenda_medicos_outro_dia(params)
    end
    respond_to &:js
  end

  private
    def set_referencia_agendas
      ReferenciaAgenda.set_connection
    end

    def set_agenda_movimentacoes
      AgendaMovimentacao.set_connection
    end

    def verify_agenda_authorization
      if !current_user.admin?
        @model = Gclinic::Model.find_by(model_class: "Agenda")
        @user_model = current_user.user_models.find_by(model_id: @model.id)
        @agenda_permissao = AgendaPermissao.find_by user_model_id: @user_model.id
      end
    end

    def check_params_for_agenda
      lambda do |*args|
        raise ArgumentError if args.empty? || args.size > 2
        arg1, arg2 = args
        return arg1 unless arg1.nil?
        return arg2 unless arg2.nil?
      end
    end

    def retorna_referencias_menu_lateral
      @medicos_do_dia= Agenda.retorna_todos_os_medicos_do_dia(current_user.empresa)
      @outros_medicos= Agenda.retorna_todos_os_medicos_com_agenda(current_user.empresa)
    end

    def find_agenda
      @id = check_params_for_agenda
      @agenda = Agenda.find_by(id: @id.call(params[:id], params[:agenda_id]))
    end

    def ransack_params
      Agenda.ransack(params[:q])
    end

    def somente_data_presente?
      if (params[:q]["data_cont(3i)"].present? && params[:q]["data_cont(2i)"].present? && params[:q]["data_cont(1i)"].present?) &&
          !params[:q][:referencia_agenda_id].present? && !params[:q][:agenda_movimentacao_nome_paciente_cont].present?
        true
      end
    end

    def referencia_agenda_e_paciente_presentes?
      params[:q][:referencia_agenda_id].present? && params[:q][:agenda_movimentacao_nome_paciente_cont].present?
    end

    def referencia_agenda_presente?
      params[:q][:referencia_agenda_id].present? && !params[:q][:agenda_movimentacao_nome_paciente_cont].present?
    end

    def nome_do_paciente_presente?
      params[:q][:agenda_movimentacao_nome_paciente_cont].present?
    end

    def ransack_result
      @search.result(distinct: agenda_wants_distinct_results?).da_empresa(@empresa.id).
              order_data.
              order_atendimento
    end

    def find_agenda_movimentacao
      @movimentacao = AgendaMovimentacao.find_by(agenda_id: @agenda.id)
    end

    def set_clientes
      @clientes = Cliente.where(empresa_id: @empresa.id)
    end

    def set_convenios
      @convenios = Convenio.where(empresa_id: @empresa.id)
    end
end