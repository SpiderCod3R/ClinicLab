json.set! :agenda do
  if @invalid_fields_for_shift_a.nil? or @invalid_fields_for_shift_b.nil?
    json.set! :not_completeded, false
    json.set! :flash do
      json.set! :notice do
        json.set! :success, I18n.t("agendas.messages.generating", resource_name: Agenda.last.referencia_agenda.profissional_nome)
      end
    end

    # => Ponto de redirecionamento
    json.set! :location do
      json.url url_for(@agendas)
    end
  else
    json.set! :not_completeded, true
    json.set! :flash do
      json.set! :messages, @invalid_fields_for_shift_a
    end
  end
end