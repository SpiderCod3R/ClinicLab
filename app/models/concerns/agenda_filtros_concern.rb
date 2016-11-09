module AgendaFiltrosConcern
  extend ActiveSupport::Concern
  included do
    attr_accessor :paciente_nome_contain, :data_contain
    class << self
      def retorna_todos_os_medicos_do_dia(resource)
        find_by_sql("SELECT DISTINCT r.id AS id, r.descricao AS descricao
                  FROM agendas AS a
                  INNER JOIN referencia_agendas ON referencia_agendas.id = a.referencia_agenda_id
                  INNER JOIN referencia_agendas AS r ON r.id = a.referencia_agenda_id
                  INNER JOIN profissionais AS p ON p.id = r.profissional_id
                  WHERE a.empresa_id=#{resource.id} AND a.data= '#{Date.today.strftime("%Y-%m-%d")}'")
      end

      def retorna_todos_os_medicos_com_agenda(resource)
        find_by_sql("SELECT DISTINCT r.id AS id, r.descricao AS descricao
                  FROM agendas AS a
                  INNER JOIN referencia_agendas ON referencia_agendas.id = a.referencia_agenda_id
                  INNER JOIN referencia_agendas AS r ON r.id = a.referencia_agenda_id
                  INNER JOIN profissionais AS p ON p.id = r.profissional_id
                  WHERE a.empresa_id=#{resource.id} AND NOT a.data= '#{Date.today.strftime("%Y-%m-%d")}'")
      end

      # def buscar_dados_agenda(resource)
      #   find_by_sql("SELECT DISTINCT *
      #               FROM agendas AS a
      #               INNER JOIN referencia_agendas ON referencia_agendas.id = a.referencia_agenda_id
      #               INNER JOIN referencia_agendas AS r ON r.id = a.referencia_agenda_id
      #               WHERE a.empresa_id=#{resource[:empresa_id]}
      #               AND   a.data= '#{Date.today.strftime("%Y-%m-%d")}'
      #               ORDER BY a.data ASC, a.atendimento_inicio asc
      #               LIMIT #{resource[:offset]}, #{resource[:page_limit]}")
      # end

      def search_agenda_medicos(resource)
        @empresa = Painel::Empresa.friendly.find(resource[:empresa_id]).id
        where(referencia_agenda_id: resource[:referencia_agenda_id], empresa_id: @empresa).
        order_data.
        offset(0).
        take(12)
      end

      def load_more_medicos(resource)
                binding.pry
        if resource[:acao].present?
          @referencia = resource[:acao].gsub("agenda_content_","")
        end

        where(referencia_agenda_id: @referencia, empresa_id: resource[:empresa_id]).
        order_data.
        offset(0).
        take(12)
      end

      def a_partir_da_data(resource)
        @param_data = Converter::DateConverter.new(resource["data_cont(1i)"].to_i, resource["data_cont(2i)"].to_i, resource["data_cont(3i)"].to_i)

        joins(:referencia_agenda).
        joins(:agenda_movimentacao).
        where("agendas.data >= ?",@param_data.to_american_format).
        where("agenda_movimentacoes.nome_paciente LIKE ?", "#{resource["agenda_movimentacao_nome_paciente_cont"]}")
      end

      def da_data(resource)
        @param_data = Converter::DateConverter.new(resource["data_cont(1i)"].to_i, resource["data_cont(2i)"].to_i, resource["data_cont(3i)"].to_i)

        joins(:referencia_agenda).
        joins(:agenda_movimentacao).
        where("agendas.data >= ?", @param_data.to_american_format)
      end
    end
  end
end