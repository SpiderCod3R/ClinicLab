#-*- coding: utf-8 -*-
class Painel::UsuarioPermissao < ApplicationRecord
  belongs_to :usuario
  belongs_to :permissao

  paginates_per 10

  scope :permissoes_adicionadas, -> {
    where("cadastrar = ? OR atualizar = ? OR exibir = ? OR deletar = ?", true, true, true, true)
  }

  def self.possuiAgenda?
    @agenda = Painel::Permissao.find_by(model_class: "Agenda")
    @permissao = where(permissao: @agenda)
    return true if !@permissao.nil?
  end
end
