#-*- coding:utf-8 -*-
class Servico < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  has_many :movimento_servico_servicos, dependent: :destroy
  has_many :movimento_servicos, through: :movimento_servico_servicos

  validates :tipo, :abreviatura, :valor, presence: true
  validates_uniqueness_of :tipo, :abreviatura, scope: :empresa_id
  validates_associated :empresa
  usar_como_dinheiro :valor
  paginates_per 10

  def to_s
    "#{tipo} - #{abreviatura}"
  end

  RANSACKABLE_ATTRIBUTES = ["tipo", "abreviatura"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
