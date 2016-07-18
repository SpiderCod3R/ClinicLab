class Cargo < ApplicationRecord
  include MetodosUteis
  validates :nome, presence: true
  has_many :profissionais

  validates_uniqueness_of :nome

  scope :pelo_nome, -> { order("nome ASC") }

  def to_s
    "#{nome}"
  end

  class << self
    def da_empresa_atual(resource)
      where(empresa_id: resource)
    end
  end
end
