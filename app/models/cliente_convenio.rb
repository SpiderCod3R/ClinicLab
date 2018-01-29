class ClienteConvenio < Connection::Factory
  include ActiveMethods
  STATUS={:ATIVO=> 1, :INATIVO=> 0}
  belongs_to :cliente
  belongs_to :convenio

  after_initialize :set_default_status, :if => :new_record?

  scope :convenio_ativo_no_momento, ->{ where(utilizando_agora: true) }
  scope :unimed, ->{ joins(:convenio).find_by("`convenios`.`nome` LIKE '%UNIMED%' ") }
  scope :petrobras, ->{ joins(:convenio).find_by("`convenios`.`nome` LIKE '%PETRO%' ") }
  

  def set_default_status
    self.status_convenio=STATUS[:ATIVO]
  end

  def petrobras?
    convenio.nome.eql?("PETROBRAS")
  end

  def unimed?
    case convenio.nome
    when "UNIMED UNIVIDA"
      return true
    when "UNIMED UNIPLAN"
      return true
    when "UNIMED INTERCAMBIO"
      return true
    else
      return false
    end
  end
end
