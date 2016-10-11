module ApplicationHelper
  def button_to_remove_fields
    tag.button 'Remove', class: 'remove_fields btn'
  end

  def link_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def app_info
    @@app_info ||= "#{
      tag.strong 'Globalnetsis GClinic2.0 app'
      } running on Ruby #{RUBY_VERSION}, Rails #{Rails::VERSION::STRING}".html_safe
  end
end
