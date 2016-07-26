class Agenda < ApplicationRecord
  belongs_to :profissional
  belongs_to :usuario
  belongs_to :empresa
  # has_many :agenda_horarios, dependent: :destroy

  # attr_accessor :segunda,
  #               :terca,
  #               :quarta,
  #               :quinta,
  #               :sexta,
  #               :turno_manha,
  #               :turno_vespertino

  # accepts_nested_attributes_for :agenda_horarios,
  #                               reject_if: proc { |attributes| attributes['hora'].blank?},
  #                               allow_destroy: true
  validates :data_inicial, :data_final,
            :profissional_id, :empresa_id,
            :usuario_id, :atendimento_duracao, presence: true

  validates_inclusion_of :atendimento_sabado,
                         :atendimento_domingo,
                         :horario_parcial,
                         :in => [true, false]
end
