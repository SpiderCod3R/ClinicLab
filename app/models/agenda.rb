require 'time'
require 'date'
class Agenda < ApplicationRecord
  attr_accessor :atendimento_manha_inicio, :atendimento_manha_final,
                :atendimento_tarde_inicio, :atendimento_tarde_final,
                :data_inicial, :data_final

  belongs_to :profissional
  belongs_to :usuario
  belongs_to :empresa

  with_options dependent: :destroy do
    has_many   :agenda_manha_horarios, class_name: "AgendaManhaHorario", foreign_key: "agenda_id"
    has_many   :agenda_tarde_horarios, class_name: "AgendaTardeHorario", foreign_key: "agenda_id"
  end

  # validates :data_inicial, :data_final, presence: true

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
    def create_by_javascript_params(resource)
      resource = JSON.parse(resource.to_json)

      # => Gerar agenda no turno da manha
      build_agenda_manha({ data_inicial: resource['data_inicial'],
                           data_final:   resource['data_final'],
                           profissional_id: resource['profissional_id'],
                           atendimento_sabado: resource['atendimento_sabado'],
                           atendimento_domingo: resource['atendimento_domingo'],
                           atendimento_manha_duracao: resource['atendimento_manha_duracao'].to_i,
                           atendimento_parcial: resource['atendimento_parcial'],
                           horarios_manha: resource['horarios_manha']
                          })
    end

    def build_agenda_manha(resource)
      x = 0
      y = 0
      z = 0
      _data_inicial = Date.parse(resource[:data_inicial])
      _data_final = Date.parse(resource[:data_final])
      _data_auxiliar = _data_inicial
      _numero_de_dias = (_data_final - _data_inicial).to_i
      horarios_manha = JSON.parse(resource[:horarios_manha].to_json)
      horarios_manha.each do |_key, horario|
        while x <= _numero_de_dias
          _inicio = Time.parse(horario['inicio'])
          _final  = Time.parse(horario['final'])
          _intervalo = TimeDifference.between(_inicio, _final).in_hours
          _horario_auxiliar_ = _inicio

          while y <= _intervalo
            _final_do_atendimento = _horario_auxiliar_.advance(minutes: resource[:atendimento_manha_duracao])

            if _data_auxiliar.strftime("%A").eql?("Saturday") && resource[:atendimento_sabado] == "0"
              break
            elsif _data_auxiliar.strftime("%A").eql?("Sunday") && resource[:atendimento_domingo] == "0"
              break
            end

            gera_agenda(resource[:empresa_id], resource[:profissional_id],
                        _data_auxiliar, resource[:atendimento_sabado],
                        resource[:atendimento_domingo], resource[:atendimento_manha_duracao],
                        resource[:atendimento_parcial], _horario_auxiliar_,
                        _final_do_atendimento)

            if _final == _final_do_atendimento
              break
            else
              _horario_auxiliar_ = _final_do_atendimento
              next
            end
            y += 1
          end
          _data_auxiliar = _data_auxiliar.advance(days: 1)
          x += 1
        end
      end
    end

    def gera_agenda(empresa_id, profissional_id, data, atendimento_sabado, atendimento_domingo, atendimento_manha_duracao,
                    atendimento_parcial, atendimento_inicio, atendimento_final)
      create!(empresa_id:                empresa_id, 
              profissional_id:           profissional_id,
              data:                      data, 
              atendimento_sabado:        atendimento_sabado,
              atendimento_domingo:       atendimento_domingo,
              atendimento_manha_duracao: atendimento_manha_duracao,
              atendimento_parcial:       atendimento_parcial,
              atendimento_inicio:        atendimento_inicio,
              atendimento_final:         atendimento_final)
    end
  end
end



# create!(empresa_id: resource[:empresa_id],
#         profissional_id: resource[:profissional_id],
#         data: _data_auxiliar,
#         atendimento_sabado: resource[:atendimento_sabado],
#         atendimento_domingo: resource[:atendimento_domingo],
#         atendimento_manha_duracao: resource[:atendimento_manha_duracao],
#         atendimento_parcial: resource[:horario_parcial],
#         atendimento_inicio: _horario_auxiliar_,
#         atendimento_final: _final_do_atendimento,
#         atendimento_parcial: resource[:atendimento_parcial]
#       )