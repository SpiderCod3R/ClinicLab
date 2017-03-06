class ClientePermissao < Connection::Factory
  include ActiveMethods

  belongs_to :user_model, class_name: 'Gclinic::UserModel'
  belongs_to :empresa

  def self.update_content(resource)
    update(user_model_id: resource[:user_model_id],
           historico: resource[:historico],
           texto_livre: resource[:texto_livre],
           pdf_upload:  resource[:pdf_upload],
           receituario: resource[:receituario])
           pdf_upload: resource[:pdf_upload],
           imagens_externas: resource[:imagens_externas])
  end
end
