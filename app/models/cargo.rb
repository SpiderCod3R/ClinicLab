class Cargo < ApplicationRecord
  include MetodosUteis
  validates :nome, presence: true, uniqueness: true

  belongs_to :empresa
  has_many :profissionais

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
