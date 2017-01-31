#-*- coding:utf-8-*-
class Gclinic::Environment < ApplicationRecord
	extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :database_name, presence: true
  validates :name, :database_name, uniqueness: true
end
