unless @usuario.valid?
  json.set! :usuario do
    json.set! :invalid, true
  end

  json.set! :message_count, @usuario.errors.messages.count

  json.set! :messages do
    json.array! @usuario.errors.messages do |_key, value|
      if _key.eql?(:password)
        _key = :"Senha"
      end
      json.set! :field, _key
      json.set! :value, value.to_param
    end
  end
else
  json.set! :usuario do
    json.set! :invalid, false
  end

  json.set! :message do
    json.set! :success, I18n.t("flash.actions.update.success", resource_name: @usuario.nome)
  end
end