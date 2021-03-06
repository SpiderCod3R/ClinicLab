class AgendaMovimentacao < Connection::Factory
  include ActiveMethods

  belongs_to :agenda
  belongs_to :cliente_convenio
  belongs_to :convenio
  belongs_to :cliente
  belongs_to :atendente, class_name: "Gclinic::User", foreign_key: "atendente_id"
  has_one :movimento_servico

  delegate :title,
           :valor,
           to: :convenio,
           prefix: true,
           allow_nil: true

  delegate :convenio,
           :status_convenio,
           :matricula,
           :titular,
           :plano,
           :validade_carteira,
           :produto,
           to: :cliente_convenio,
           prefix: true,
           allow_nil: true

  delegate :nome,
           to: :cliente,
           prefix: true,
           allow_nil: true

  validates :agenda_id, :nome_paciente, :indicacao, :telefone_paciente, presence: true
  validates_associated :agenda

  def no_convenio_registered?
    sem_convenio.present?
  end

  def sem_cliente_convenio?
    return if self.cliente_convenio.nil?
  end

  def convenio_desc
    "#{convenio_title}"
  end

  def change_agenda_status
    case confirmacao
    when "N.V"
      self.agenda.status= I18n.t("agendas.helpers.didnt_come")
    when "D.M"
      self.agenda.status= I18n.t("agendas.helpers.unmarked_by_doctor")
    when "R.P"
      self.agenda.status= I18n.t("agendas.helpers.remarked_by_doctor")
    when "R.M"
      self.agenda.status= I18n.t("agendas.helpers.remarked_by_doctor")
    when "Desistiu"
      self.agenda.status= I18n.t("agendas.helpers.give_up")
    else
      self.agenda.status= I18n.t("agendas.helpers.scheduled")
    end
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
          indicacao:         resource[:indicacao],
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
