class Historico < ApplicationRecord
  belongs_to :usuario
  belongs_to :cliente

  class << self
    def do_cliente_atual(resource)
      where(cliente_id: resource)
    end
  end
end