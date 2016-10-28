module AgendasHelper
  def action
    if action_name == 'advanced_search'
      :post
    else
      :get
    end
  end

  def link_to_toggle_agenda_search_modes
    if action_name == 'advanced_search'
      link_to('Busca Simplificada', painel_empresa_agendas_path(current_usuario.empresa_id))
    else
      link_to('Busca Avaçada', advanced_search_painel_empresa_agendas_path(current_usuario.empresa_id))
    end
  end

  def agenda_column_headers
    %i(id profissional_titulo data status).freeze
  end

  def agenda_columns_fields
    %i(id profissional_titulo data status).freeze
  end

  def alterar_horario_agenda_numero(object_id)
    return "Trocar horário da agenda - nº #{object_id}"
  end

  def movimentar_agenda_numero(object)
    return "Movimentar agenda - nº #{object.id} - Referência - #{object.referencia_agenda.descricao}"
  end

  def remarcar_agenda_numero(object_id)
    return "Remarcar horário da agenda - nº #{object_id}"
  end

  def max_result_per_page
    # => numero maximo de resultados
    25
  end

  def post_title_length
    #numero maximo de caracteres na postagem
    15
  end

  # def agenda_profissional_and_movimentacoes
  #   %w(profissional).freeze
  # end

  # def condition_fields
  #   %w(data fields condition).freeze
  # end

  # def value_fields
  #   %w(fields condition).freeze
  # end

  def agenda_wants_distinct_results?
    params[:distinct].to_i == 1
  end

  def display_results_information(count)
    if count > results_limit
      "Your first #{results_limit} results out of #{count} total"
    else
      "Your #{pluralize(count, 'result')}"
    end
  end
end