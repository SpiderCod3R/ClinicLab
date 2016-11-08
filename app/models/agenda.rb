require 'time'
require 'date'
require 'converters/date_converter'
require 'converters/time_converter'
class Agenda < ApplicationRecord
  include AgendaConcern
  include AgendaFiltrosConcern

  paginates_per 10

  attr_accessor :atendimento_manha_inicio, :atendimento_manha_final,
                :atendimento_tarde_inicio, :atendimento_tarde_final,
                :data_inicial, :data_final, :atendimento_turno_a_duracao,
                :atendimento_turno_b_duracao, :hora

  attr_reader :param_data, :param_hora, :agenda_disponivel
  attr_writer :agenda_disponivel, :param_data

  scope :disponibilidade, ->(boolean = true) { where(status: "VAGO") }

  '''
    OBS. IMPORTANTE: 
    OS scope A SEGUIR INTERCALAM AS POSIÇÕES NA GRID DA AGENDA
    CUIDADO AO MANUSEA-LOS
  '''
  scope :pela_referencia, -> { order(referencia_agenda_id: :asc, ) }
  scope :order_atendimento, -> { order(atendimento_inicio: :ASC) }
  scope :order_data, -> { order(data: :ASC) }
  scope :do_dia, -> { where(data: Date.today) }
  scope :da_empresa, -> (empresa_id) { where(empresa_id: empresa_id) }
  '''
    FIM DA OBSERVAÇÃO
    TENHAM ATENÇÃO PLEASE!
  '''

  scope :nome_paciente_like, -> (name) { where("agenda_movimentacao.nome_paciente ilike ?", name)}

  belongs_to :referencia_agenda
  has_one :profissional, through: :referencia_agenda
  belongs_to :usuario
  belongs_to :empresa, class_name: "Painel::Empresa", foreign_key: "empresa_id"
  has_one :agenda_movimentacao

  delegate :id, :descricao, :profissional,
           to: :referencia_agenda,
           prefix: true,
           allow_nil: true

  delegate :nome,
           to: :empresa,
           prefix: true,
           allow_nil: true

  def profissional_titulo
    "#{referencia_agenda_profissional.nome} - #{referencia_agenda_profissional.cargo_nome}"
  end

  def referencia
    "#{referencia_agenda_descricao}"
  end

  def turno
    if Time.parse(atendimento_inicio).strftime("%H") >= "12"
      I18n.t('agendas.helpers.shift.afternoon')
    else
      I18n.t('agendas.helpers.shift.morning')
    end
  end

  def confirmacao?
    return unless try(:agenda_movimentacao)
    agenda_movimentacao.confirmacao?
  end

  def clean
    self.agenda_movimentacao.destroy
    self.status= I18n.t("agendas.helpers.free")
    self.save
  end

  def set_didnt_came
    self.agenda_movimentacao.update_attributes(confirmacao: "N.V.")
    self.status= I18n.t("agendas.helpers.didnt_came")
    self.save
  end

  def check_availability(resource)
    # => Checando disponibilidade da agenda
    @param_data = Converter::DateConverter.new(resource["param_data(1i)"].to_i, resource["param_data(2i)"].to_i, resource["param_data(3i)"].to_i)
    @param_hora = Converter::TimeConverter.new(resource["hora(4i)"], resource["hora(5i)"])
    @agenda_disponivel = false
    @data_valida =(@param_data >= Date.today)
    if @data_valida
      @agenda_disponivel = Agenda.exists?(["data LIKE ? AND atendimento_inicio LIKE ? AND status LIKE ? AND referencia_agenda_id LIKE ?", "%#{@param_data.to_american_format}%", "%#{@param_hora.to_format}%", "%#{I18n.t('agendas.helpers.free')}%", "%#{resource[:referencia_agenda_id]}%"])
    end
    return [@agenda_disponivel, @data_valida]
  end

  def remark(params, confirmation)
    # => Encontrando o horario e alterando o dia e hora
    @agenda_disponivel   = Agenda.find_by(["data LIKE ? AND atendimento_inicio LIKE ? AND status LIKE ? AND referencia_agenda_id LIKE ?", "%#{@param_data.to_american_format}%", "%#{@param_hora.to_format}%", "%#{I18n.t('agendas.helpers.free')}%", "%#{params[:referencia_agenda_id]}%"])
    @agenda_movimentacao = AgendaMovimentacao.find_by_agenda_id(self.id)
    @agenda_movimentacao.update_attributes(agenda_id: @agenda_disponivel.id, confirmacao: confirmation)
    @agenda_movimentacao.agenda.update_attributes(status: I18n.t('agendas.helpers.scheduled'))
    self.status = I18n.t('agendas.helpers.free')
    self.save
  end

  def change_day_or_time(resource)
    remark(resource, "T.R.")
    return @agenda_movimentacao.agenda
  end

  def remarked_by_pacient(resource)
    remark(resource, "R.P.")
    return @agenda_movimentacao.agenda
  end

  def remarked_by_doctor(resource)
    remark(resource, "R.M.")
    return @agenda_movimentacao.agenda
  end

  def backup_agenda
    @backup_agenda = Agenda.new(self.attributes.except("id"))
    @backup_agenda.status=(I18n.t('agendas.helpers.free'))
    @backup_agenda.save
  end

  def unmarked_by_doctor
    self.agenda_movimentacao.update_attributes(confirmacao: "D.M.")
    self.status=(I18n.t('agendas.helpers.unmarked_by_doctor'))
    self.save
  end

  def unmarked_by_pacient
    self.agenda_movimentacao.update_attributes(confirmacao: "D.P.")
    self.status=(I18n.t('agendas.helpers.unmarked_by_pacient'))
    self.save
  end

  def attended(resource)
    @param_hora = Converter::TimeConverter.new(resource["hora_atendimento(4i)"], resource["hora_atendimento(5i)"])
    self.agenda_movimentacao.update_attributes(confirmacao: "A.T.E.")
    self.status=(I18n.t('agendas.helpers.attended'))
    self.hora_atendimento=@param_hora.to_format
    self.save
  end

  private_class_method :ransackable_scopes

  private
    def self.ransortable_attributes(auth_object = nil)
      column_names - ['id', 'atendimento_sabado', 'atendimento_domingo',
                      'atendimento_parcial', 
                      'atendimento_final', 'atendimento_duracao',
                      'created_at', 'updated_at',
                      'atendimento_manha_final', 'atendimento_tarde_final',
                      'empresa_id', 'usuario_id', 'status'
                    ]
    end

    def self.ransackable_attributes(auth_object = nil)
      ransortable_attributes + _ransackers.keys
    end

    def self.ransackable_scopes(auth_object = nil)
      %i(disponibilidade)
    end
end 