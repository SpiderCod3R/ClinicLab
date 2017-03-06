class SalaEspera < Connection::Factory
  include ActiveMethods

  belongs_to :cliente
  belongs_to :referencia_agenda
  belongs_to :agenda

  scope :em_espera, -> {where(status: "ESPERA")}
  scope :atendido, -> {where.not(status: "ESPERA")}
end
