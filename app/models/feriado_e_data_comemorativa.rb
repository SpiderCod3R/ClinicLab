#-*- coding:utf-8 -*-
class FeriadoEDataComemorativa < Connection::Factory
  include ActiveMethods

  validates :data, :descricao, presence: true, uniqueness: true
end
