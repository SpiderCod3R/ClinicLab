json.set! :agenda do
  if params[:agenda][:id] != ""
    json.set! :page, true
    json.url empresa_clinic_sheet_cliente_path(current_user.empresa, cliente_id: @cliente.id, agenda_id: @agenda.id)
  end
  json.set! :page, false
  json.set! :message, "Receituario atualizado com sucesso."
end

