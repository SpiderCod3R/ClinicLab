class Painel::Master < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :timeoutable

  before_create :only_one

  def only_one
    if Painel::Master.count >= 1
      errors.add(:admin, " - apenas UM é permitido")
    end
  end
end
