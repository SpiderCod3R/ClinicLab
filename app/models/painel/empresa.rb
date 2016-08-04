#-*-coding:utf-8-*-
class Painel::Empresa < ApplicationRecord
  validates :nome, :status, presence: true, uniqueness: true

  with_options dependent: :destroy do
    has_many :atendimentos
    has_many :cargos
    has_many :convenios
    has_many :clientes
    has_many :centro_de_custos
    has_one  :configuracao_relatorio
    has_many :operadoras
    has_many :pacientes
    has_many :profissionais
    has_many :pacientes
  end
end
