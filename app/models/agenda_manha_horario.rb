#-*-coding:utf-8-*-
class AgendaManhaHorario < ApplicationRecord
  belongs_to :agenda
  validates_associated :agenda

  DIA_DA_SEMANA = %w(Segunda-Feira Terça-Feira Quarta-Feira Quinta-Feira Sexta-Feira Sabado Domingo)
  TURNO = %W(Manha Tarde)

  def profissional_nome
    agenda.profissional_nome
  end

  def empresa_nome
    agenda.empresa_nome
  end
end
