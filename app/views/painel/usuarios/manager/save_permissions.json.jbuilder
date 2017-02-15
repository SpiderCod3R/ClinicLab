unless @user.valid?
  json.set! :usuario do
    json.set! :invalid, true
  end

  json.set! :message_count, @user.errors.messages.count

  json.set! :messages do
    json.array! @user.errors.messages do |_key, value|
      if _key.eql?(:password)
        _key = :"Senha"
      end
      json.set! :field, _key
      json.set! :value, value.to_param
    end
  end
else
  json.set! :environment do
    json.set! :url, @user.empresa.slug
  end
  json.set! :messages do
    json.set! :success, I18n.t("flash.actions.create.success", resource_name: @user.name)
  end
end