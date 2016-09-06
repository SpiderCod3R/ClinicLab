json.set! :agenda do
  if @agenda.valid?
    json.set! :successfully_created, true
    # => Notificação de agenda criada com sucesso
    json.set! :flash do
      json.set! :notice do
        json.set! :success, I18n.t("flash.actions.create.success", resource_name: "Agenda")
      end
    end

    # => Ponto de redirecionamento
    json.set! :location do
      json.url url_for(@agendas)
    end
  else
    json.set! :successfully_created, false
  end
end