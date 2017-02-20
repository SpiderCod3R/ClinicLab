#-*- coding:utf-8 -*-
class ClienteReceituario < ApplicationRecord
  belongs_to :cliente
  belongs_to :user, class_name: "Painel::Usuario", foreing_key: :user_id
  validates :content, presence: true
end
