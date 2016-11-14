class Support::AgendaSupportController < ApplicationController
  include AgendasHelper
  before_action :authenticate_usuario!
  before_action :find_empresa


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
    end

    def apenas_date
      params[:q]["data_cont(3i)"].present? && params[:q]["data_cont(2i)"].present? && params[:q]["data_cont(1i)"].present?
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