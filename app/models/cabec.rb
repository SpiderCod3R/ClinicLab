class Cabec < ApplicationRecord
    validates :nome, :texto, presence: true
end
