#-*- coding:utf-8-*-
class Painel::Permissao < ApplicationRecord
  validates :nome, :model_class, presence: true, uniqueness: true
end
