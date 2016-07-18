class CentroDeCusto < ApplicationRecord
  include MetodosUteis
  validates :nome, presence: true

  def to_s
    "#{nome}"
  end
end
