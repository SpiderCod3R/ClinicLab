class Grupo < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  has_many :grupo_exame_procedimentos, dependent: :destroy
  has_many :exame_procedimentos, through: :grupo_exame_procedimentos

  accepts_nested_attributes_for :grupo_exame_procedimentos, allow_destroy: true

  validates_presence_of :nome

  RANSACKABLE_ATTRIBUTES = ["nome"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  paginates_per 10
end
