unless @usuario.valid?
  unless @usuario.errors.nil?
    @usuario_error_messages = @usuario.errors.messages
    @usuario_error_messages.each do |_key, value|
      @usuario_error_messages[_key].each do |v|
        # toastr.error('<%= "#{v}" %>', '<%= "#{_key}" %>')
      end
    end
  end
else
  json.set! :messages do
    json.set! :success, I18n.t("flash.actions.create.success", resource_name: @usuario.nome)
  end
end