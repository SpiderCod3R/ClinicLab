class AddClienteConvenioIdToAgendaMovimentacoes < ActiveRecord::Migration[5.0]
  def change
    add_reference :agenda_movimentacoes, :cliente_convenio, foreign_key: true
  end
end
