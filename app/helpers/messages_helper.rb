module MessagesHelper
  FLASH_MSG = {
    notice:  'notice',
    success: 'success',
    error:   'error',
    warning: 'warning',
  }

  def css_class_for(flash_type)
    FLASH_MSG.fetch(flash_type, flash_type.to_s)
  end

  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  # def flash_messages(opts = {})
  #   flash.each do |msg_type, message|
  #     concat(content_tag(:div, message, class: "alert #{css_class_for(msg_type)} alert-dismissible text-center fade in", role: 'alert') do
  #       concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
  #         concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
  #         concat content_tag(:span, 'Close', class: 'sr-only')
  #       end)
  #       concat message
  #     end)
  #   end
  # end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      unless msg_type.to_s == 'timedout'
        concat(content_tag(:div, id: "flash-message") do
          concat(content_tag(:div, message, class: "message alert alert-#{bootstrap_class_for(msg_type)} fade in alert-dismissible ext-center fade in", role: 'alert') do
            if msg_type == "notice" or msg_type == "success"
              concat image_tag("icons/glyphicons-194-circle-ok.icon.png", width: "30", height: "30")
            elsif msg_type == "error" or msg_type == "alert"
              concat image_tag("icons/glyphicons-193-redclose.png", style: "margin-left: 2%;", width: "30", height: "30")
            elsif msg_type == "warning"
              concat image_tag("icons/glyphicons-197-warning-exclamation-mark.png", style: "margin-left: 2%;", width: "30", height: "30")
            end
            concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
              concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
              concat content_tag(:span, 'Close', class: 'sr-only')
            end)
            concat message
          end)
        end)
      end
    end
    nil
  end
end
