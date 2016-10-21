class RenameColumnProfissionalIdToReferenciaAgendaIdOnAgendas < ActiveRecord::Migration[5.0]
  def change
    change_table :agendas do |t|
      t.remove_index :profissional_id
      t.rename :profissional_id, :referencia_agenda_id
    end
  end
end
