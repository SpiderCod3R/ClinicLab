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

      # => Gerar agenda no turno da tarde
      build_agenda_tarde({ data_inicial: resource['data_inicial'],
                           data_final:   resource['data_final'],
                           profissional_id: resource['profissional_id'],
                           atendimento_sabado: resource['atendimento_sabado'],
                           atendimento_domingo: resource['atendimento_domingo'],
                           atendimento_manha_duracao: resource['atendimento_manha_duracao'].to_i,
                           atendimento_parcial: resource['atendimento_parcial'],
                           horarios_tarde: resource['horarios_tarde']
                          })
    end

    def build_agenda_manha(resource)
      # => Contadores da Matrix
      y = 0
      z = 0

      # => Primeiramente deve-se descobir o numero de dias entre as datas
      _numero_de_dias = (Date.parse(resource[:data_final]) - Date.parse(resource[:data_inicial])).to_i

      # => Deve-se converter para se trabalhar com o formato do Ruby
      _data_auxiliar = Date.parse(resource[:data_inicial])
      _data_final = Date.parse(resource[:data_final])
      # => O 1º while varre o numero de dias informado entre as datas de inicio e fim
      while y <= _numero_de_dias
        # => O foreach horarios_manha varre a quantidade de horarios por dia da semana
        horarios_manha = JSON.parse(resource[:horarios_manha].to_json)
        horarios_manha.each do |_key, horario|
          # => Deve-se converter para se trabalhar com o formato do Ruby
          _inicio = Time.parse(horario['inicio'])
          _final  = Time.parse(horario['final'])

          # => Deve-se descobrir o intervalo entre os horarios informados
          _intervalo = TimeDifference.between(_inicio, _final).in_hours
          _horario_auxiliar_ = _inicio

          # => Alternador de dias
          if y >= 1
            _data_auxiliar = _data_auxiliar.advance(days: 1)
          end

          # => O 2º while varre o espaco de tempo entre o inicio e fim do atendimento
          while z <= _intervalo
            _final_do_atendimento = _horario_auxiliar_.advance(minutes: resource[:atendimento_manha_duracao])

            if resource[:atendimento_sabado].nil?
              break
            else
              next
            end

            if resource[:atendimento_domingo].nil?
              break
            else
              next
            end

            create!(empresa_id: resource[:empresa_id],
                  profissional_id: resource[:profissional_id],
                  data: _data_auxiliar,
                  atendimento_sabado: resource[:atendimento_sabado],
                  atendimento_domingo: resource[:atendimento_domingo],
                  atendimento_manha_duracao: resource[:atendimento_manha_duracao],
                  atendimento_parcial: resource[:horario_parcial],
                  atendimento_inicio: _horario_auxiliar_,
                  atendimento_final: _final_do_atendimento,
                  atendimento_parcial: resource[:atendimento_parcial])

            _horario_auxiliar_ = _final_do_atendimento

            # => Condicional para parar ou prosseguir com a contagem do horario inicial ou final
            # até o final do atendimento informado no params
            if _final == _final_do_atendimento
              break
            else
              next
            end

            z += 1
          end

          # => Condicional para verificar a se a data correspondente
          #    confere a data final informada no params
          if _data_auxiliar == _data_final
            break
          else
            next
          end
        end
        y += 1
      end
    end

    def build_agenda_tarde(resource)
      # => Contadores da Matrix
      y = 0
      z = 0

      # => Primeiramente deve-se descobir o numero de dias entre as datas
      _numero_de_dias = (Date.parse(resource[:data_final]) - Date.parse(resource[:data_inicial])).to_i

      # => Deve-se converter para se trabalhar com o formato do Ruby
      _data_auxiliar = Date.parse(resource[:data_inicial])
      _data_final = Date.parse(resource[:data_final])
      # => O 1º while varre o numero de dias informado entre as datas de inicio e fim
      while y <= _numero_de_dias
        # => O foreach horarios_manha varre a quantidade de horarios por dia da semana
        horarios_tarde = JSON.parse(resource[:horarios_tarde].to_json)
        horarios_tarde.each do |_key, horario|
          # => Deve-se converter para se trabalhar com o formato do Ruby
          _inicio = Time.parse(horario['inicio'])
          _final  = Time.parse(horario['final'])

          # => Deve-se descobrir o intervalo entre os horarios informados
          _intervalo = TimeDifference.between(_inicio, _final).in_hours
          _horario_auxiliar_ = _inicio

          # => Alternador de dias
          if y >= 1
            _data_auxiliar = _data_auxiliar.advance(days: 1)
          end

          # => O 2º while varre o espaco de tempo entre o inicio e fim do atendimento
          while z <= _intervalo
            _final_do_atendimento = _horario_auxiliar_.advance(minutes: resource[:atendimento_manha_duracao])

            if resource[:atendimento_sabado].nil?
              break
            else
              next
            end

            if resource[:atendimento_domingo].nil?
              break
            else
              next
            end

            create!(empresa_id: resource[:empresa_id],
                  profissional_id: resource[:profissional_id],
                  data: _data_auxiliar,
                  atendimento_sabado:  resource[:atendimento_sabado],
                  atendimento_domingo: resource[:atendimento_domingo],
                  atendimento_tarde_duracao: resource[:atendimento_manha_duracao],
                  atendimento_parcial: resource[:horario_parcial],
                  atendimento_inicio: _horario_auxiliar_,
                  atendimento_final: _final_do_atendimento,
                  atendimento_parcial: resource[:atendimento_parcial])

            _horario_auxiliar_ = _final_do_atendimento

            # => Condicional para parar ou prosseguir com a contagem do horario inicial ou final
            # até o final do atendimento informado no params
            if _final == _final_do_atendimento
              break
            else
              next
            end

            z += 1
          end

          # => Condicional para verificar a se a data correspondente
          #    confere a data final informada no params
          if _data_auxiliar == _data_final
            break
          else
            next
          end
        end
        y += 1
      end
    end
  end
end