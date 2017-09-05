if params[:agenda]
  json.set! :agenda do
    json.set! :page, true
    json.set! :message, "Receiturario atualizados com sucesso."
    json.url empresa_clinic_sheet_cliente_path(current_user.empresa, cliente_id: @cliente.id, agenda_id: @agenda.id)
  end
end
