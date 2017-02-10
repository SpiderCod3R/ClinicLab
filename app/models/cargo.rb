class Cargo < ApplicationRecord
  include MetodosUteis
  include AtivandoStatus
  validates :nome, presence: true, uniqueness: true
  validates :nome, presence: true
  has_many :profissionais
  belongs_to :empresa
  has_many :profissionais
  paginates_per 10
  scope :pelo_nome, -> { order("nome ASC") }

  RANSACKABLE_ATTRIBUTES = ["nome"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  def to_s
    "#{nome}"
  end

  class << self
    def da_empresa_atual(resource)
      where(empresa_id: resource)
    end
  end
end