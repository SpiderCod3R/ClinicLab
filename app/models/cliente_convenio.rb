class ClienteConvenio < ApplicationRecord
  belongs_to :cliente
  belongs_to :convenio
end