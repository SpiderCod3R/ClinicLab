class Receituario < Connection::Factory
  include ActiveMethods
  extend FriendlyId

  friendly_id :nome, use: :slugged
  before_create :set_slug

  validates :nome, :receita, presence: true

  def set_slug
    self.slug = self.nome.downcase.gsub(" ", "-")
  end

  paginates_per 10
  belongs_to :empresa, class_name: "Painel::Empresa"

  RANSACKABLE_ATTRIBUTES = ["nome"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
