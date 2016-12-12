#-*- coding: utf-8 -*-
class Painel::UsuarioPermissao < ApplicationRecord
  belongs_to :usuario
  belongs_to :permissao

  paginates_per 10

  scope :permissoes_adicionadas, -> {
    where("cadastrar = ? OR atualizar = ? OR exibir = ? OR deletar = ?", true, true, true, true)
  }

  '''
    METODO PARA VERIFICAR SE O USUARIO POSSUI Agenda
    EM SUAS MODALIDADES PERMITIDAS
  '''
  def self.possuiAgenda?
    @agenda_permissao = Painel::Permissao.find_by(model_class: "Agenda")
    @permissao = where(permissao_id: @agenda_permissao.id)
    @permissao = @permissao.permissoes_adicionadas
    return true if !@permissao.empty?
  end
end
