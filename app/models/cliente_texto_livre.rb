class ClienteTextoLivre < ApplicationRecord
  belongs_to :cliente
  belongs_to :texto_livre
end
