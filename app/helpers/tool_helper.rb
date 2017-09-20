module ToolHelper
  def day_name(week_day)
    Date::DAYNAMES[week_day]
  end

  def hora_formatada(hora)
    hora.strftime("%H:%M") if hora.present?
  end

  def data_e_hora_formatada(data, hora)
    if data.present? && hora.present?
      content_tag(:label) do
        data.strftime("%d/%m/%Y") + " - " + hora.strftime("%H:%M")
      end
    end
  end

  def date_to_format(date)
    date.strftime("%d/%m/%Y") if date.present?
  end

  def status(resource)
    return resource ? "ATIVO" : "INATIVO"
  end

  def yes_or_no(resource)
    return resource ? "SIM" : "NÃO"
  end

  def documento(documento)
    if documento == '1'
      'Física'
    elsif documento == '2'
      'Jurídica'
    else
      ''
    end
  end

  def sexo_formatado(s)
    if s.upcase.eql?("F")
      return 'Feminino'
    elsif s.upcase.eql?("M")
      return 'Masculino'
    end
  end

  def novo
    t(:new, scope: [:bootstrap, :helpers, :links])
  end

  def empresa_atual
    current_usuario.empresa
  end

  def render_tree_categorias(ary, &block)
    concat(content_tag(:em, block.binding) do
      ary.map(&:categoria_nome).join(", ")
    end)
  end

  def render_tree(ary, &block)
    concat(content_tag(:ul, block.binding) do
      for elem in ary
        concat(content_tag(:li, block.binding) do
          yield elem
        end)
      end
    end)
  end

  '''
    MENU AUTOMATIZADO
  '''
  def render_menu_tree(hash, &block)
    for elem in hash
      if can? :read, elem.permissao.model_class.constantize
        concat(content_tag(:li, block.binding) do
          link = I18n.transliterate(elem.permissao.nome.gsub(' ', '_'))
          link_to elem.permissao.nome.upcase, "#{link.pluralize.downcase}/new"
        end)
      end
    end
  end

  def remove_quotations(str)
    if str.starts_with?('"')
      str = str.slice(1..-1)
    end
    if str.ends_with?('"')
      str = str.slice(0..-2)
    end
  end

  def link_to_novo(resource)
    link_to "#{image_tag("icons/glyphicons-191-circle-plus.png", width: 22, height: 22)}
             NOVO USUÁRIO".html_safe, resource, class: 'btn btn-default'
  end

  def link_to_visualizar(resource)
    link_to "#{image_tag("icons/glyphicons-610-journal.png", width: 22, height: 22)}".html_safe,
      resource, title: t(:show, scope: [:bootstrap, :helpers, :links]), class: 'btn btn-default'
  end

  def link_to_editar(resource)
    link_to "#{image_tag("icons/glyphicons-151-edit.png", width: 22, height: 22)}".html_safe,
    resource, title: t(:edit, scope: [:bootstrap, :helpers, :links]), class: 'btn btn-default'
  end

  def link_to_change_password(resource)
    link_to "#{image_tag("icons/glyphicons-45-keys.png", width: 22, height: 22)}".html_safe,
    resource, title: t(:edit, scope: [:bootstrap, :helpers, :links]), class: 'btn btn-default'
  end

  def link_to_delete(resource)
    link_to "#{image_tag("icons/glyphicons-17-bin-white.png", width: 22, height: 22)}".html_safe,
    resource, method: "delete", class: 'delete-confirm btn btn-danger',
    data: {confirm: "Excluir '#{resource.to_s}'"}
  end

  def link_to_modificar_permissoes(resource)
    link_to "#{image_tag("icons/glyphicons-137-cogwheel.png", width: 22, height: 22)}".html_safe,
    resource, title: "Alterar permissões", class: 'btn btn-default'
  end

  def link_to_first_page(options={})
    link_to options[:text], options[:path], remote: true, class: 'btn btn-default'
  end

  def link_to_advance_page(options={})
    link_to options[:text], options[:path], remote: true, class: 'btn btn-default'
  end

  def link_to_back_page(options={})
    link_to options[:text], options[:path], remote: true, class: 'btn btn-default'
  end

  def link_to_last_page(options={})
    link_to options[:text], options[:path], remote: true, class: 'btn btn-default'
  end

  def link_to_print_free_text(options={})
    link_to options[:text], options[:path], class: 'btn btn-default'
  end

  def link_to_print_recipe(options={})
    link_to options[:text], options[:path], target: :_blank, class: 'btn btn-default'
  end

  def link_to_ortographic_corretor
    link_to t('labels.ortographic_corrector'), "https://www.corretorortografico.com/", target: :_blank, class: "btn btn-default"
  end
end
