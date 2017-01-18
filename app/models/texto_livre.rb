#-*- coding:utf-8 -*-
class TextoLivre < ApplicationRecord
  belongs_to :empresa, class_name: "Painel::Empresa", foreign_key: "empresa_id"
  belongs_to :servico
  has_many :cliente_texto_livres

  validates :nome, :servico_id, :content, presence: true
  validates_uniqueness_of :content, scope: :empresa_id
  validates_associated :empresa

  def addEmpresa=(aEmpresa)
    self.empresa=aEmpresa
  end

  def self.search(servico_id, nome) 
    where("servico_id LIKE ? AND nome LIKE ?", "%#{servico_id}%", "%#{nome}%")
  end
end