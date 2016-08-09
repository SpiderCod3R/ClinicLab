#-*- coding:utf-8-*-
class Painel::Permissao < ApplicationRecord
  extend ActiveModel::Naming
  has_many :empresa_permissoes

  validates :nome, presence: true
  validates :nome, uniqueness: true
  validates :model_class, presence: {message: I18n.t('painel.helpers.messages.nao_pode_estar_em_branco', class_name: "Nome da Classe")}
  validates :model_class, uniqueness: true

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.human_attribute_name(attr, options = {})
    attr
  end

  def self.lookup_ancestors
    [self]
  end

  paginates_per 10
end
