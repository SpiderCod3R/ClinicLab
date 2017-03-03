class SalaEspera < Connection::Factory
  include ActiveMethods

  belongs_to :cliente
  belongs_to :referencia_agenda
end
