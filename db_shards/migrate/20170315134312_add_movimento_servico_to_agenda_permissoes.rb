class AddMovimentoServicoToAgendaPermissoes < ActiveRecord::Migration[5.0]
  def change
    add_column :agenda_permissoes, :movimento_servico, :boolean
  end
end
