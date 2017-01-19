class CentroDeCusto < ApplicationRecord
  include MetodosUteis
  validates :nome, presence: true

  def to_s
    "#{nome}"
  end

  RANSACKABLE_ATTRIBUTES = ["nome"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
