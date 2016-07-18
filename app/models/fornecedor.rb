class Fornecedor < ApplicationRecord
  validates :status, :nome, :telefone, :celular,  presence: true
  validates :endereco, :bairro, :estado_id, :cidade_id,  presence: true

  validates_associated :estado, :cidade
  belongs_to :estado
  belongs_to :cidade

  usar_como_cpf :cpf
  usar_como_cnpj :cnpj
end
