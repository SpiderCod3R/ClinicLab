require 'time'
require 'date'
class Agenda < ApplicationRecord
  belongs_to :profissional
  belongs_to :usuario
  belongs_to :empresa

  with_options dependent: :destroy do
    has_many   :agenda_manha_horarios, class_name: "AgendaManhaHorario", foreign_key: "agenda_id"
    has_many   :agenda_tarde_horarios, class_name: "AgendaTardeHorario", foreign_key: "agenda_id"
  end

  validates :data_inicial, :data_final, presence: true

  accepts_nested_attributes_for :agenda_manha_horarios, allow_destroy: true

  accepts_nested_attributes_for :agenda_tarde_horarios, allow_destroy: true

  delegate :nome,
           to: :profissional,
           prefix: true,
           allow_nil: true

  delegate :nome,
           to: :empresa,
           prefix: true,
           allow_nil: true

  class << self
    def new_by_javascript_params(resource)
      new(empresa_id: resource[:empresa_id],
          profissional_id: resource[:profissional_id],
          data_inicial: resource[:data_inicial],
          data_final: resource[:data_final],
          atendimento_sabado: resource[:atendimento_sabado],
          atendimento_domingo: resource[:atendimento_domingo],
          atendimento_manha_duracao: resource[:intervalo_manha],
          horario_parcial: resource[:horario_parcial])
    end
  end

  
  # Date.parse("07/09/2016")

  def cria_horarios_turno_manha(resource)
    _numero_de_dias = (data_final - data_inicial).to_i
    dados = JSON.parse(resource.to_json)

    dados.each do |_key, value|
      x = 0
      y = 0
      _inicio = Time.parse(value['inicio'])
      _final  = Time.parse(value['final'])
      _intervalo = TimeDifference.between(_inicio, _final).in_hours

      agenda_manha_horarios.build(dia: value['dia'],
                                  turno: 'Manhã',
                                  inicio_do_atendimento: _inicio, 
                                  final_do_atendimento: _inicio.advance(minutes: atendimento_manha_duracao.to_i))

      _horario_auxiliar_ = Time.parse(agenda_manha_horarios.last.final_do_atendimento)
      # while x <= _numero_de_dias
        while y <= _intervalo
          _final_do_atendimento = _horario_auxiliar_.advance(minutes: atendimento_manha_duracao.to_i)
          agenda_manha_horarios.build(dia: value['dia'],
                                       turno: 'Manhã',
                                       inicio_do_atendimento: _horario_auxiliar_, 
                                       final_do_atendimento:  _final_do_atendimento)
          _horario_auxiliar_ = _final_do_atendimento
          if _final == _final_do_atendimento
            break
          else
            next
          end
          y += 1
        end
        # x += 1
      # end
    end
  end

  def cria_horarios_turno_tarde(resource)
    
  end
end