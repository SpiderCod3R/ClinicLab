#-*- coding:utf-8 -*-
class Servico < ApplicationRecord
  belongs_to :empresa, class_name: "Painel::Empresa", foreign_key: "empresa_id"
  validates :tipo, :abreviatura, presence: true
  validates_uniqueness_of :tipo, :abreviatura, scope: :empresa_id
  validates_associated :empresa

  def addEmpresa=(aEmpresa)
    self.empresa = aEmpresa
  end

  def to_s
    "#{tipo} - #{abreviatura}"
  end
end
