class Sadt < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  belongs_to :cliente
  has_many :sadt_grupos
  has_many :grupos, through: :sadt_grupos

  accepts_nested_attributes_for :sadt_grupos, allow_destroy: true

  paginates_per 10
end