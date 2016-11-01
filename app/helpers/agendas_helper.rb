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

  def alterar_horario_agenda_numero(object_id)
    return "Trocar horário da agenda - nº #{object_id}"
  end

  def movimentar_agenda_numero(object)
    return "Movimentar agenda - nº #{object.id} - Referência - #{object.referencia_agenda.descricao}"
  end

  def remarcar_agenda_numero(object_id)
    return "Remarcar horário da agenda - nº #{object_id}"
  end

  def show_clock_period(object)
    "#{Time.parse(object.atendimento_inicio).strftime("%H:%M")} - #{object.periodo}"
  end

  def max_result_per_page
    # => numero maximo de resultados
    25
  end

  def post_title_length
    #numero maximo de caracteres na postagem
    15
  end

  def carrega_navbar_da_agenda
    render 'painel/agendas/componentes/navbar'
  end

  def carrega_setor_alpha_da_agenda
    render 'painel/agendas/componentes/setor_alpha'
  end

  def carrega_opcoes_agenda(agenda)
    render 'painel/agendas/componentes/opcoes', { agenda: agenda}
  end


  def agenda_wants_distinct_results?
    params[:distinct].to_i == 1
  end
end