class AddIndicacaoToAgendaMovimentacoes < ActiveRecord::Migration[5.0]
  def change
    add_column :agenda_movimentacoes, :indicacao, :string
  end
end
