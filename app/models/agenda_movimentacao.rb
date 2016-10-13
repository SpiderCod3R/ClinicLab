class AgendaMovimentacao < ApplicationRecord
  belongs_to :agenda
  belongs_to :convenio
  belongs_to :cliente
  belongs_to :atendente, class_name: "Painel::Usuario", foreign_key: "atendente_id"

  delegate :nome,
           :title,
           to: :convenio,
           prefix: true,
           allow_nil: true

  delegate :nome,
           to: :cliente,
           prefix: true,
           allow_nil: true

  validates :agenda_id, presence: true
  # validates :convenio_id, presence: true, if: :no_convenio_registered?
  validates_associated :agenda

  # after_save :change_agenda_status

  def no_convenio_registered?
    sem_convenio.present?
  end

  def convenio_desc
    "#{convenio_title}"
  end

  def change_agenda_status
    self.agenda.status= I18n.t("agendas.helpers.scheduled")
    self.agenda.save
  end

  class << self
    def build_movimentacao(resource)
      new(agenda_id:         resource[:agenda_id],
          convenio_id:       resource[:convenio_id],
          sem_convenio:      resource[:sem_convenio],
          observacoes:       resource[:observacoes],
          confirmacao:       resource[:confirmacao],
          nome_paciente:     resource[:nome_paciente],
          telefone_paciente: resource[:telefone_paciente],
          email_paciente:    resource[:email_paciente],
          solicitante_id:    resource[:solicitante_id])
    end
  end

  def update_movimentacao(resource)
    update_attributes(agenda_id:         resource[:agenda_id],
                      convenio_id:       resource[:convenio_id],
                      sem_convenio:      resource[:sem_convenio],
                      observacoes:       resource[:observacoes],
                      confirmacao:       resource[:confirmacao],
                      nome_paciente:     resource[:nome_paciente],
                      telefone_paciente: resource[:telefone_paciente],
                      email_paciente:    resource[:email_paciente],
                      solicitante_id:    resource[:solicitante_id])
  end
end
