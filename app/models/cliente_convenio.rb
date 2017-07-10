class ClienteConvenio < Connection::Factory
  include ActiveMethods
  STATUS={:ATIVO=> 1, :INATIVO=> 0}
  belongs_to :cliente
  belongs_to :convenio

  after_initialize :set_default_status, :if => :new_record?


  def set_default_status
    self.status_convenio=STATUS[:ATIVO]
  end
end
