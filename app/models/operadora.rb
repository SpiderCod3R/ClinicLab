class Operadora < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  has_many :profissionais, dependent: :destroy
  paginates_per 10
  scope :by_name, -> {order("nome ASC")}

  validates :nome, presence: true, uniqueness: {case_sensitive: false}
  before_save :upcase_nome

  def to_s
    "Operadora - #{nome}"
  end

  RANSACKABLE_ATTRIBUTES = ["nome"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  private
    def upcase_nome
      self.nome.upcase!
    end
end
