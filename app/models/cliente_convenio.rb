class ClienteConvenio < Connection::Factory
  include ActiveMethods
  belongs_to :cliente
  belongs_to :convenio
end