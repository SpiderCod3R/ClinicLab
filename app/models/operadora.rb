class Operadora < ApplicationRecord
  belongs_to :empresa
  has_many :profissionais, dependent: :destroy

  scope :pelo_nome, -> {order("nome ASC")}

  validates :nome, presence: true, uniqueness: {case_sensitive: false}
  before_save :upcase_nome

  def to_s
    "Operadora - #{nome}"
  end

  private
    def upcase_nome
      self.nome.upcase!
    end
end
