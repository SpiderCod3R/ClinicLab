class Empresa < ApplicationRecord
  include MetodosUteis

  with_options dependent: :destroy do
    has_many :agendas
    has_many :pacientes
    has_many :atendimentos
    has_many :profissionais
    has_many :convenios
    has_many :pacientes
    has_many :centro_de_custos
    has_many :usuarios
    has_many :cargos
    has_many :empresa_permissao_empresas
    has_many :permissao_empresas, through: :empresa_permissao_empresas
    has_one  :configuracao_relatorio
    has_many :operadoras
    has_many :clientes
  end

  accepts_nested_attributes_for :usuarios, allow_destroy: true
  validates_associated :permissao_empresas

  validates :nome, presence: true

  def possui_pelo_menos_um_administrador
    @empresa = self.usuarios.administradores
    @empresa.count
  end

  def to_s
    nome
  end
end
