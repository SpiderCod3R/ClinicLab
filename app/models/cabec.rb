class Cabec < ApplicationRecord
  validates :nome, :texto, presence: true

  RANSACKABLE_ATTRIBUTES = ["texto", "nome"]

  def self.ransackable_attributes auth_object = nil
    (RANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
