json.set! :agenda do
  if @agenda_manha.class == ActiveModel::Errors
    json.set! :not_completeded, true
    json.set! :flash do
      json.set! :notice do
        json.set! :warning, @agenda_manha[:data][0][:message] if @agenda_manha[:data].present?
      end
    end
  elsif @agenda_tarde.class == ActiveModel::Errors
    json.set! :not_completeded, true
    json.set! :flash do
      json.set! :notice do
        json.set! :warning, @agenda_tarde[:data][0][:message] if @agenda_tarde[:data].present?
      end
    end
  else
    json.set! :not_completeded, false
    json.set! :flash do
      json.set! :notice do
        json.set! :success, I18n.t("flash.actions.create.success", resource_name: "Agenda")
      end
    end

    # => Ponto de redirecionamento
    json.set! :location do
      json.url url_for(@agendas)
    end
  end
end