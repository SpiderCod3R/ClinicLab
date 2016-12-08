class AgendaPermissao < ApplicationRecord
  belongs_to :agenda
  belongs_to :usuario
  belongs_to :empresa
end
