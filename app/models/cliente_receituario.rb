#-*- coding:utf-8 -*-
class ClienteReceituario < Connection::Factory
  include ActiveMethods

  belongs_to :cliente
  belongs_to :user, class_name: "Painel::Usuario", foreign_key: :user_id
  validates  :content, presence: true
  paginates_per 1


  def next
    self.class.where("id < ? AND cliente_id = ?", id, cliente_id).last
  end

  def previous
    self.class.where("id > ? AND cliente_id = ?", id, cliente_id).first
  end
end



