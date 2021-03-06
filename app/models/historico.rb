class Historico < Connection::Factory
  include ActiveMethods

  belongs_to :user, class_name: "Gclinic::User", foreign_key: "usuario_id"
  belongs_to :cliente

  class << self
    def do_cliente_atual(resource)
      where(cliente_id: resource)
    end
  end
end