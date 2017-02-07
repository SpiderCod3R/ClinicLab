class ClientePermissao < Connection::Factory
  include ActiveMethods

  belongs_to :usuario_permissao, class_name: 'Painel::UsuarioPermissao', foreign_key:  "usuario_permissoes_id"
  belongs_to :empresa

  def self.update_content(resource)
    update(usuario_permissoes_id: resource[:usuario_permissoes_id],
           historico: resource[:historico],
           texto_livre: resource[:texto_livre],
           pdf_upload: resource[:pdf_upload])
  end
end
