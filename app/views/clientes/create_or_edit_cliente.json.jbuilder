if @cliente.valid?
  json.set! :valid, @cliente.valid?
  json.set! :message, "Dados do cliente atualizados com sucesso."
  json.url empresa_clinic_sheet_cliente_path(current_user.empresa, cliente_id: @cliente.id, agenda_id: @agenda.id)
else
  json.set! :valid, @cliente.valid?
  @error_messages=[]
  @messages = JSON.parse(@cliente.errors.messages.to_json)
  @messages.map do |_key, value|
    @error_messages << "#{value.to_s.gsub("[", "").gsub("]", "").gsub('"', "")}"
  end.join
  json.set! :messages, @error_messages
end
