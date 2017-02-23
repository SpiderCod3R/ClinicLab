#-*- coding:utf-8 -*-
class Servico < Connection::Factory
  include ActiveMethods

  belongs_to :empresa
  validates :tipo, :abreviatura, presence: true
  validates_uniqueness_of :tipo, :abreviatura, scope: :empresa_id
  validates_associated :empresa
  paginates_per 10

  def to_s
    "#{tipo} - #{abreviatura}"
  end

  RANSACKABLE_ATTRIBUTES = ["tipo", "abreviatura"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
