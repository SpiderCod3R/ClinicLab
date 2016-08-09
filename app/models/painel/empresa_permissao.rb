class Painel::EmpresaPermissao < ApplicationRecord
  attr_accessor :permissao_ids
  attr_writer   :permissao_ids


  belongs_to :empresa
  belongs_to :permissao

  paginates_per 10
end
