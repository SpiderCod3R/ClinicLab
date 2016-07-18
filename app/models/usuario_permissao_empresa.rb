class UsuarioPermissaoEmpresa < ApplicationRecord
  include MetodosUteis
  belongs_to :permissao_empresa, class_name: 'PermissaoEmpresa',
                                 foreign_key: 'permissao_empresa_id'
  belongs_to :usuario
end
