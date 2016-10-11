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

  validates :agenda_id, presence: true
  validates :convenio_id, presence: true, if: :no_convenio_registered?
  validates_associated :agenda

  after_save :change_agenda_status

  def no_convenio_registered?
    sem_convenio.present?
  end

  def convenio_desc
    "#{convenio_title}"
  end

  def change_agenda_status
    agenda.status= I18n.t("agendas.helpers.scheduled")
    agenda.save
  end
end
