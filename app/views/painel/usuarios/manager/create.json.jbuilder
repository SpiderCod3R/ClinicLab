unless @user.valid?
  unless @user.errors.nil?
    @user_error_messages = @user.errors.messages
    @user_error_messages.each do |_key, value|
      @user_error_messages[_key].each do |v|
        # toastr.error('<%= "#{v}" %>', '<%= "#{_key}" %>')
      end
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