class Convenio < ApplicationRecord
  include MetodosUteis
  belongs_to :empresa
  has_many   :pacientes, dependent: :destroy

  validates :nome, :valor, presence: true
  validates :nome, uniqueness: true
  usar_como_dinheiro :valor

  scope :pelo_nome, -> { order("nome ASC") }

  def title
    "#{id} - #{nome}"
  end
end
