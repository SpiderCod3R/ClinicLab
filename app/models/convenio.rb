class Convenio < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  belongs_to :estado
  belongs_to :cidade
  has_many :cliente_convenios, dependent: :destroy
  has_many :clientes, through: :cliente_convenios

  validates :nome, :valor, presence: true
  validates :nome, uniqueness: true
  usar_como_dinheiro :valor

  paginates_per 10
  scope :pelo_nome, -> { order("nome ASC") }

  def title
    "#{id} - #{nome}"
  end

  RANSACKABLE_ATTRIBUTES = ["nome"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
