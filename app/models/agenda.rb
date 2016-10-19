require 'time'
require 'date'
require 'converters/date_converter'
require 'converters/time_converter'
class Agenda < ApplicationRecord
  include AgendaConcern
  paginates_per 10

  attr_accessor :atendimento_manha_inicio, :atendimento_manha_final,
                :atendimento_tarde_inicio, :atendimento_tarde_final,
                :data_inicial, :data_final, :atendimento_turno_a_duracao,
                :atendimento_turno_b_duracao, :hora

  attr_reader :param_data, :param_hora, :agenda_disponivel
  attr_writer :agenda_disponivel
  scope :disponibilidade, ->(boolean = true) { where(status: "VAGO") }
  scope :nome_paciente_like, -> (name) { where("agenda_movimentacao.nome_paciente ilike ?", name)}

  belongs_to :profissional
  belongs_to :usuario
  belongs_to :empresa
  has_one :agenda_movimentacao

  delegate :id, :nome,
           to: :profissional,
           prefix: true,
           allow_nil: true

  delegate :nome,
           to: :empresa,
           prefix: true,
           allow_nil: true

  def profissional_titulo
    "#{profissional_nome} - #{profissional.cargo_nome}"
  end

  def turno
    if Time.parse(atendimento_inicio).strftime("%H") >= "12"
      I18n.t('agendas.helpers.shift.afternoon')
    else
      I18n.t('agendas.helpers.shift.morning')
    end
  end

  def clean
    self.agenda_movimentacao.destroy
    self.status= I18n.t("agendas.helpers.free")
    self.save
  end

  def check_availability(resource)
    # => Checando disponibilidade da agenda
    @param_data = Converter::DateConverter.new(resource["data(1i)"].to_i, resource["data(2i)"].to_i, resource["data(3i)"].to_i)
    @param_hora = Converter::TimeConverter.new(resource["hora(4i)"], resource["hora(5i)"])
    @agenda_disponivel = Agenda.exists?(["data LIKE ? AND atendimento_inicio LIKE ? AND status LIKE ?", "%#{@param_data.to_american_format}%", "%#{@param_hora.to_format}%", "%#{I18n.t('agendas.helpers.free')}%"])
    return @agenda_disponivel
  end

  def change_day_or_time(resource)
    # => Encontrando o horario
    @agenda_disponivel = Agenda.find_by("data LIKE ? AND atendimento_inicio LIKE ? AND status LIKE ?", "%#{@param_data.to_american_format}%", "%#{@param_hora.to_format}%", "%#{I18n.t('agendas.helpers.free')}%")
    @agenda_movimentacao = AgendaMovimentacao.find_by_agenda_id(self.id)
    @agenda_movimentacao.update_attributes(agenda_id: @agenda_disponivel.id)
    @agenda_movimentacao.agenda.update_attributes(status: I18n.t('agendas.helpers.scheduled'))
    self.status = I18n.t('agendas.helpers.free')
    self.save
    return @agenda_movimentacao.agenda
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