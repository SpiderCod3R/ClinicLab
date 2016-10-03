require 'time'
require 'date'
class Agenda < ApplicationRecord
  extend ActiveModel::Naming

  paginates_per 25
  attr_accessor :atendimento_manha_inicio, :atendimento_manha_final,
                :atendimento_tarde_inicio, :atendimento_tarde_final,
                :data_inicial, :data_final, :atendimento_turno_a_duracao,
                :atendimento_turno_b_duracao

  belongs_to :profissional
  belongs_to :usuario
  belongs_to :empresa

  delegate :nome,
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

  class << self
    # => Gerar agenda no turno da manha -> Diurno
    def create_horarios_turno_a_by_javascript_params(resource)
      resource = JSON.parse(resource.to_json)

      build_agenda({ empresa_id:   resource['agenda']['empresa_id'],
                     usuario_id:   resource['agenda']['usuario_id'],
                     data_inicial: resource['agenda']['data_inicial'],
                     data_final:   resource['agenda']['data_final'],
                     profissional_id: resource['agenda']['profissional_id'],
                     atendimento_sabado: resource['agenda']['atendimento_sabado'],
                     atendimento_domingo: resource['agenda']['atendimento_domingo'],
                     atendimento_duracao: resource['horarios']['turno_a']['atendimento_duracao'].to_i,
                     atendimento_parcial: resource['agenda']['atendimento_parcial'],
                     horarios: resource['horarios']['turno_a']['horarios_turno_a']
                    })
    end

    def build_agenda(resource)
      x = 0
      _data_inicial = Date.parse(resource[:data_inicial])
      _data_final = Date.parse(resource[:data_final])
      _data_auxiliar = _data_inicial
      _numero_de_dias = (_data_final - _data_inicial).to_i

      while x <= _numero_de_dias
        if Date::DAYNAMES[_data_auxiliar.wday] == "Segunda-Feira"
          manager(_data_auxiliar, resource)
        elsif Date::DAYNAMES[_data_auxiliar.wday] == "Terça-Feira"
          manager(_data_auxiliar, resource)
        elsif Date::DAYNAMES[_data_auxiliar.wday] == "Quarta-Feira"
          manager(_data_auxiliar, resource)
        elsif Date::DAYNAMES[_data_auxiliar.wday] == "Quinta-Feira"
          manager(_data_auxiliar, resource)
        elsif Date::DAYNAMES[_data_auxiliar.wday] == "Sexta-Feira"
          manager(_data_auxiliar, resource)
        elsif Date::DAYNAMES[_data_auxiliar.wday] == "Sábado"
          manager(_data_auxiliar, resource)
        elsif Date::DAYNAMES[_data_auxiliar.wday] == "Domingo"
          manager(_data_auxiliar, resource)
        end

        _data_auxiliar = _data_auxiliar.advance(days: 1)

        x = x + 1
      end
    end

    # => Methodo para verificar se ja existe uma agenda para um determinado dia e horario
    def agenda_exist?(agendas, data, inicio, intervalo)
      if @agendas.any?
        @agendas.each do |agenda|
          inicio_do_atendimento= Time.parse(agenda.atendimento_inicio)
          if agenda.data.strftime("%d/%m/%Y") == data.strftime("%d/%m/%Y") and 
            agenda.atendimento_duracao.to_i == intervalo.to_i and
            agenda.status.eql?("VAGO")
            return true
          elsif agenda.data.strftime("%d/%m/%Y") == data.strftime("%d/%m/%Y") and 
                agenda.atendimento_duracao.to_i != intervalo.to_i and
                Time.parse(agenda.atendimento_inicio).strftime("%H:%M") == inicio.strftime("%H:%M") and 
                agenda.status.eql?("VAGO")
            return true
          end
        end
      end
      return false
    end

    # => Metodo para gerenciar os registros da agenda a ser criada
    def manager(_data_auxiliar, resource)
      y = 0
      # => Executando uma busca fina da agenda
      @agendas = Agenda.where(profissional_id: resource[:profissional_id], empresa_id: resource[:empresa_id])

      # => Convertendo resource[:horarios] para JSON
      horarios = JSON.parse(resource[:horarios].to_json)

      horarios.each do |_key, value|
        _inicio_do_atendimento = Time.parse(value['inicio'])
        _final_pre_determinado  = Time.parse(value['final'])
        _intervalo = TimeDifference.between(_inicio_do_atendimento, _final_pre_determinado).in_hours

        if value['dia'] == Date::DAYNAMES[_data_auxiliar.wday]
          # => bloco para Verificar se a agenda já existe na base de dados
          if agenda_exist?(@agendas, _data_auxiliar, _inicio_do_atendimento, resource[:atendimento_duracao])
            @agendas = Agenda.where(profissional_id: resource[:profissional_id],
                                   empresa_id: resource[:empresa_id],
                                   data: _data_auxiliar,
                                   status: "VAGO")

            @agendas.each do |agenda|
              horario_auxiliar = Time.parse(agenda.atendimento_inicio)
              agenda_data      = agenda.data
              agenda.destroy

              while y <= _intervalo
                if horario_auxiliar.strftime("%H:%M") == _inicio_do_atendimento.strftime("%H:%M") and
                  _data_auxiliar.strftime("%d/%m/%Y") == agenda.data.strftime("%d/%m/%Y")

                  _final_do_atendimento = _inicio_do_atendimento.advance(minutes: resource[:atendimento_duracao])

                  gera_agenda(resource[:empresa_id], resource[:usuario_id],
                              resource[:profissional_id], _data_auxiliar, resource[:atendimento_sabado],
                              resource[:atendimento_domingo], resource[:atendimento_duracao],
                              resource[:atendimento_parcial], _inicio_do_atendimento, _final_do_atendimento)

                  # => condição de parada dos horarios
                  if _final_pre_determinado == _final_do_atendimento
                    _ultimo_atendimento = _final_do_atendimento.advance(minutes: resource[:atendimento_duracao])
                    gera_agenda(resource[:empresa_id], resource[:usuario_id],
                                resource[:profissional_id], _data_auxiliar, resource[:atendimento_sabado],
                                resource[:atendimento_domingo], resource[:atendimento_duracao],
                                resource[:atendimento_parcial], _final_do_atendimento, _ultimo_atendimento)
                    break
                  else
                    _inicio_do_atendimento = _final_do_atendimento
                    horario_auxiliar       = _inicio_do_atendimento
                    next
                  end
                end
                y = y + 1
              end
            end
          else
            # binding.pry
            while y <= _intervalo
              # => Determinando o final do atendimento
              _final_do_atendimento = _inicio_do_atendimento.advance(minutes: resource[:atendimento_duracao])

              gera_agenda(resource[:empresa_id], resource[:usuario_id],
                          resource[:profissional_id], _data_auxiliar, resource[:atendimento_sabado],
                          resource[:atendimento_domingo], resource[:atendimento_duracao],
                          resource[:atendimento_parcial], _inicio_do_atendimento, _final_do_atendimento)

              # => condição de parada dos horarios
              if _final_pre_determinado == _final_do_atendimento
                _ultimo_atendimento = _final_do_atendimento.advance(minutes: resource[:atendimento_duracao])
                gera_agenda(resource[:empresa_id], resource[:usuario_id],
                            resource[:profissional_id], _data_auxiliar, resource[:atendimento_sabado],
                            resource[:atendimento_domingo], resource[:atendimento_duracao],
                            resource[:atendimento_parcial], _final_do_atendimento, _ultimo_atendimento)
                break
              else
                _inicio_do_atendimento = _final_do_atendimento
                next
              end
              y = y + 1
            end
          end
        end
      end
    end

    # => Metodo criado para a geração da agenda de forma simplificada
    def gera_agenda(empresa_id, usuario_id, profissional_id, data,
                    atendimento_sabado, atendimento_domingo,
                    atendimento_duracao, atendimento_parcial,
                    atendimento_inicio, atendimento_final)
      create!(empresa_id:           empresa_id, 
              usuario_id:           usuario_id,
              profissional_id:      profissional_id,
              data:                 data, 
              atendimento_sabado:   atendimento_sabado,
              atendimento_domingo:  atendimento_domingo,
              atendimento_duracao:  atendimento_duracao,
              atendimento_parcial:  atendimento_parcial,
              atendimento_inicio:   atendimento_inicio,
              atendimento_final:    atendimento_final,
              status:               "VAGO")
    end
  end
end