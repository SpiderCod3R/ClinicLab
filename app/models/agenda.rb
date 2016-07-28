class Agenda < ApplicationRecord
  belongs_to :profissional
  belongs_to :usuario
  belongs_to :empresa
  has_many   :agenda_manha_horarios, dependent: :destroy
  has_many   :agenda_tarde_horarios, dependent: :destroy

  after_create :remaneja_horarios, unless: Proc.new { |agenda| agenda.horario_parcial? }

  validates :data_inicial, :data_final,
            :atendimento_duracao, presence: true

  # validates_inclusion_of :atendimento_sabado,
                         # :atendimento_domingo,
                         # :horario_parcial,
                         # :in => [true, false]

  accepts_nested_attributes_for :agenda_manha_horarios,
                                reject_if: proc { |attributes| attributes['inicio_do_atendimento', 'final_do_atendimento'].blank?},
                                allow_destroy: true

  accepts_nested_attributes_for :agenda_tarde_horarios,
                                reject_if: proc { |attributes| attributes['inicio_do_atendimento', 'final_do_atendimento'].blank?},
                                allow_destroy: true
  def remaneja_horarios
    
  end
end
