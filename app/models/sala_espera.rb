require 'time'
require 'date'
require 'converters/date_converter'
require 'converters/time_converter'
class SalaEspera < Connection::Factory
  include ActiveMethods

  paginates_per 3

  belongs_to :cliente
  belongs_to :referencia_agenda
  belongs_to :agenda

  scope :em_espera, -> {where(status: "ESPERA")}
  scope :atendido, -> {where.not(status: "ESPERA")}

  class << self
    def search_by_data(params)
      self.set_connection
      @param_data = Converter::DateConverter.new(params[:data]["sala_espera(1i)"].to_i, params[:data]["sala_espera(2i)"].to_i, params[:data]["sala_espera(3i)"].to_i)
      find_by_sql("SELECT DISTINCT
                    s.id AS id,
                    m.cliente_id As cliente_id,
                    s.agenda_id As agenda_id,
                    s.status As status,
                    s.data As data,
                    s.hora_agendada As hora_agendada,
                    s.hora_chegada As hora_chegada,
                    s.hora_inicio_atendimento As hora_inicio_atendimento,
                    s.hora_fim_atendimento As hora_fim_atendimento,
                    m.nome_paciente As nome_paciente
                   FROM sala_esperas as s
                   INNER JOIN agenda_movimentacoes as m ON m.agenda_id = s.agenda_id
                   WHERE s.data='#{@param_data.to_american_format}'")
    end

    def search(params)
      self.set_connection
      @param_data = Converter::DateConverter.new(params[:data]["sala_espera(1i)"].to_i, params[:data]["sala_espera(2i)"].to_i, params[:data]["sala_espera(3i)"].to_i)
      collection = []
      if params[:status][0] == "Agendados"
        status = "ESPERA"
        collection = _select_without_pacient(@param_data.to_american_format, status)
      end

      if params[:status][0] == "Atendidos"
        status = "Atendido"
        collection = _select_without_pacient(@param_data.to_american_format, status)
      end

      if params[:status][0] == "Todos"
        collection = _select_without_pacient_and_status_todos(@param_data.to_american_format)
      end
      return collection
    end

    def search_whith_name(params)
      self.set_connection
      @param_data = Converter::DateConverter.new(params[:data]["sala_espera(1i)"].to_i, params[:data]["sala_espera(2i)"].to_i, params[:data]["sala_espera(3i)"].to_i)
      collection = []
      if params[:status][0] == "Agendados"
        status = "ESPERA"
        collection = _select_pacient_with_status(@param_data.to_american_format, status, params[:paciente_nome])
      end

      if params[:status][0] == "Atendidos"
        status = "Atendido"
        collection = _select_pacient_with_status(@param_data.to_american_format, status, params[:paciente_nome])
      end

      if params[:status][0] == "Todos"
        collection = _select_pacient_without_status(@param_data.to_american_format, params[:paciente_nome])
      end
      return collection
    end

    def _select_without_pacient(data, status)
      find_by_sql("SELECT DISTINCT
                    s.id AS id,
                    m.cliente_id As cliente_id,
                    s.agenda_id As agenda_id,
                    s.status As status,
                    s.data As data,
                    s.hora_agendada As hora_agendada,
                    s.hora_chegada As hora_chegada,
                    s.hora_inicio_atendimento As hora_inicio_atendimento,
                    s.hora_fim_atendimento As hora_fim_atendimento,
                    m.nome_paciente As nome_paciente
                   FROM sala_esperas as s
                   INNER JOIN agenda_movimentacoes as m ON m.agenda_id = s.agenda_id
                   WHERE s.data='#{data}'
                   AND s.status='#{status}'; ")
    end

    def _select_without_pacient_and_status_todos(data)
      find_by_sql("SELECT DISTINCT
                    s.id AS id,
                    m.cliente_id As cliente_id,
                    s.agenda_id As agenda_id,
                    s.status As status,
                    s.data As data,
                    s.hora_agendada As hora_agendada,
                    s.hora_chegada As hora_chegada,
                    s.hora_inicio_atendimento As hora_inicio_atendimento,
                    s.hora_fim_atendimento As hora_fim_atendimento,
                    m.nome_paciente As nome_paciente
                   FROM sala_esperas as s
                   INNER JOIN agenda_movimentacoes as m ON m.agenda_id = s.agenda_id
                   WHERE s.data='#{data}'")
    end

    def _select_pacient_with_status(data, status, nome_paciente)
      find_by_sql("SELECT DISTINCT
                   s.id AS id,
                   m.cliente_id As cliente_id,
                   s.agenda_id As agenda_id,
                   s.status As status,
                   s.data As data,
                   s.hora_agendada As hora_agendada,
                   s.hora_chegada As hora_chegada,
                   s.hora_inicio_atendimento As hora_inicio_atendimento,
                   s.hora_fim_atendimento As hora_fim_atendimento,
                   m.nome_paciente As nome_paciente
                   FROM sala_esperas as s
                   INNER JOIN agenda_movimentacoes as m ON m.agenda_id = s.agenda_id
                   WHERE s.data='#{data}'
                   AND s.status='#{status}'
                   AND m.nome_paciente LIKE '%#{nome_paciente}%'; ")
    end

    def _select_pacient_without_status(data, nome_paciente)
      find_by_sql("SELECT DISTINCT
                    s.id,
                    m.cliente_id,
                    s.agenda_id,
                    s.status,
                    s.data,
                    s.hora_agendada,
                    s.hora_chegada,
                    s.hora_inicio_atendimento,
                    s.hora_fim_atendimento,
                    m.nome_paciente
                   FROM sala_esperas as s
                   INNER JOIN agenda_movimentacoes as m ON m.agenda_id = s.agenda_id
                   WHERE s.data='#{data}'
                   AND m.nome_paciente LIKE '%#{nome_paciente}%'; ")
    end
  end
end
