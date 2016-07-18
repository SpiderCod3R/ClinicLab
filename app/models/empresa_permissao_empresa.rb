class EmpresaPermissaoEmpresa < ApplicationRecord
  include MetodosUteis
  belongs_to :empresa
  belongs_to :permissao_empresa
end
