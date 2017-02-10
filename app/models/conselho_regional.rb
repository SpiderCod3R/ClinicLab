class ConselhoRegional < ApplicationRecord
  validates :sigla, presence: true
  validates :descricao, presence: true
  before_save :upcase_sigla
  scope :pelo_nome, -> { order("nome ASC") }
  scope :pela_sigla, -> { order("sigla ASC") }
  paginates_per 10

  def self.search(status, id, sigla, search) 
    where("status LIKE ? AND id LIKE ? AND sigla LIKE ? AND sigla LIKE ?", "%#{status}%", "%#{id}%", "%#{sigla}%", "%#{search}%")
  end

  protected

  def upcase_sigla
    self.sigla.upcase
  end

end
