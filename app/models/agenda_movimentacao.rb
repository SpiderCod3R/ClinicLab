class AgendaMovimentacao < ApplicationRecord
  belongs_to :agenda
  belongs_to :convenio
  belongs_to :cliente
  belongs_to :atendente, class_name: "Painel::Usuario", foreign_key: "atendente_id"

  delegate :nome,
           to: :convenio,
           prefix: true,
           allow_nil: true

  delegate :nome,
           to: :cliente,
           prefix: true,
           allow_nil: true

  validates :agenda_id, :convenio_id, :cliente_id, presence: true
  validates_associated :agenda, :convenio, :cliente

end
