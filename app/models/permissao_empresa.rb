class PermissaoEmpresa < ApplicationRecord
  include MetodosUteis
  # Empresa
  has_many :empresa_permissao_empresas
  has_many :empresas, through: :empresa_permissao_empresas

  # Funcionario 
  has_many :usuario_permissao_empresas
  has_many :usuarios, through: :usuario_permissao_empresas

  accepts_nested_attributes_for :usuario_permissao_empresas, allow_destroy: true

  validates_presence_of :modulo, :nome
  validates_uniqueness_of :modulo, :nome
end
