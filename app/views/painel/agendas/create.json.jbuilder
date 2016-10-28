json.set! :agenda do
  if @completed
    json.set! :completeded, @completed
    json.set! :flash do
      json.set! :notice do
        json.set! :success, I18n.t("agendas.messages.generating", referency: Agenda.last.referencia_agenda.descricao, referency_resource: Agenda.last.referencia_agenda.profissional.nome)
      end
    end

    json.set! :location do
      json.url url_for(@agendas)
    end
  else
    json.set! :completeded, @completed

    json.set! :location do
      json.url url_for(@agendas)
    end
  end
end