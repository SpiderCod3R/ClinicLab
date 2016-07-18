class TextoLivre < ApplicationRecord
	validates :nome, :texto, presence: true
end
