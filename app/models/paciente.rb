class Paciente < ApplicationRecord
  include MetodosUteis
  before_save :upcased_attributes

  belongs_to :convenio
  belongs_to :estado
  belongs_to :cidade
  belongs_to :empresa

  # validates_associated :estado, :cidade

  validates :nome, :rg, :cpf, :data_nascimento, :telefone,
            :endereco, :bairro, :cidade, :estado, :nome_da_mae,
            presence: true
  validates_uniqueness_of :cpf, :rg


def to_s
  "Paciente - #{nome} - #{rg}"
end

  def salvar
    self.save
  end

  def atualizar(resource)
    self.update(resource)
  end

  def self.busca_id(id)
    self.find(id)
  end

  def upcased=(value)
    return value
  end

  def upcased_attributes
    self.nome.upcase!
    self.nome_da_mae.upcase!
    self.endereco.upcase!
    self.bairro.upcase!
  end
end
