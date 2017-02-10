module AgendasHelper
  def tipo_de_acao(resource)
    return resource.gsub('agenda_content_', '')
  end

  def build_line_agendas(object)
    render 'agenda_tr', { agenda: object }
  end

  def change_color_by_status(resource, &block)
    if resource.status.eql?(I18n.t("agendas.helpers.scheduled")) && resource.data.eql?(Date.today)
      concat(content_tag(:tr, block.binding, id: I18n.t('agendas.helpers.identity', resource_id: resource.id), class: "success tr_agenda") do
        yield
      end)
    end

    if resource.status.eql?(I18n.t("agendas.helpers.scheduled")) && !resource.data.eql?(Date.today)
      concat(content_tag(:tr, block.binding, id: I18n.t('agendas.helpers.identity', resource_id: resource.id), class: "danger tr_agenda") do
        yield
      end)
    end

    if resource.status.eql?(I18n.t("agendas.helpers.unmarked_by_pacient")) || resource.status.eql?(I18n.t("agendas.helpers.unmarked_by_doctor"))
      concat(content_tag(:tr, block.binding, id: I18n.t('agendas.helpers.identity', resource_id: resource.id), class: "attention tr_agenda") do
        yield
      end)
    end

    if resource.status == "Não Veio"
      concat(content_tag(:tr, block.binding, id: I18n.t('agendas.helpers.identity', resource_id: resource.id), class: "orange tr_agenda") do
        yield
      end)
    end

    if resource.status.eql?(I18n.t("agendas.helpers.attended"))
      concat(content_tag(:tr, id: "agenda_id_#{resource.id}" , class: "danger tr_agenda") do
        yield
      end)
    end

    if resource.status.eql?(I18n.t("agendas.helpers.free"))
      if resource.data == Date.today
        concat(content_tag(:tr, block.binding, id: I18n.t('agendas.helpers.identity', resource_id: resource.id), class: "info tr_agenda") do
          yield
        end)
      end

      if resource.data != Date.today
        concat(content_tag(:tr, block.binding, id: I18n.t('agendas.helpers.identity', resource_id: resource.id), class: "tr_agenda") do
          yield
        end)
      end
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