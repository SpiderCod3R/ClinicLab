class Sadt < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  belongs_to :cliente
  has_many :sadt_exame_procedimentos
  has_many :exame_procedimentos, through: :sadt_exame_procedimentos

  accepts_nested_attributes_for :sadt_exame_procedimentos, allow_destroy: true

  paginates_per 10
end