json.set! :agenda do
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