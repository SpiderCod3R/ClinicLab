class Fornecedor < Connection::Factory
  include ActiveMethods

  validates :status, :nome, :telefone, :celular,  presence: true
  validates :endereco, :bairro, :estado_id, :cidade_id,  presence: true

  validates_associated :estado, :cidade
  belongs_to :estado
  belongs_to :cidade

  usar_como_cpf :cpf
  usar_como_cnpj :cnpj

  RANSACKABLE_ATTRIBUTES = ["nome", "telefone", "celular"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
