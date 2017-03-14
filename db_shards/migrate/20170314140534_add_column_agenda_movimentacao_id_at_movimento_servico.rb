class AddColumnAgendaMovimentacaoIdAtMovimentoServico < ActiveRecord::Migration[5.0]
  def change
    add_reference :movimento_servicos, :agenda_movimentacao, foreign_key: true
  end
end
