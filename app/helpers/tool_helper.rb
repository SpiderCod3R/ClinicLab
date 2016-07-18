module ToolHelper
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

  def render_menu_tree(hash, &block)
    for elem in hash
      if can? :create, elem.modulo.constantize
        concat(content_tag(:li, block.binding) do
          link_to elem.nome.upcase, "#{elem.modulo.pluralize.downcase}/new"
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
end
