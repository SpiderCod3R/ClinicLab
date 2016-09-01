class Painel::EmpresaPermissao < ApplicationRecord
  attr_accessor :permissao_ids
  attr_writer   :permissao_ids


  belongs_to :empresa
  belongs_to :permissao

  '''
    VALIDAÇÕES IMPORTANTES
  '''
  validates_associated :empresa
  validates_uniqueness_of :permissao_id, :scope => :empresa_id

  paginates_per 10
end
