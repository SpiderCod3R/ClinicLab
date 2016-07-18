class Funcao < ApplicationRecord
  include MetodosUteis
  after_create :upcased_attributes
  validates :nome, :descricao, presence: true
  validates_uniqueness_of :nome

  def upcased_attributes
    self.nome.upcase!
    self.descricao.upcase!
    self.save
  end
end
