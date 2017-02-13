class Cabec < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  validates :nome, :texto, presence: true

  RANSACKABLE_ATTRIBUTES = ["texto", "nome"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  paginates_per 10
end
