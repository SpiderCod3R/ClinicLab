if !@user.valid?
  json.set! :valid do
    json.set! :success, false
  end

  json.set! :messages do
    json.set! :alert, I18n.t("flash.actions.create.alert", resource_name: @user.name)
  end

  if !@user.errors.nil?
    json.set! :errors do
      @user_error_messages = @user.errors.messages
      json.array! @user_error_messages.each do |_key, value|
        @user_error_messages[_key].each do |v|
          json.erro "#{v} - #{_key}"
        end
      end
    end
  end
else
  json.set! :valid do
    json.set! :success, true
  end
  json.set! :environment do
    @url = Empresa.find(@user.empresa_id).slug
    json.set! :url, @url
  end
  json.set! :messages do
    json.set! :success, I18n.t("flash.actions.create.success", resource_name: @user.name)
  end
end