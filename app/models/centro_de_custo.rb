class CentroDeCusto < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  validates :nome, presence: true
  paginates_per 10
  def to_s
    "#{nome}"
  end

  RANSACKABLE_ATTRIBUTES = ["nome"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
