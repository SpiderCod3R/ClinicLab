class AddReferenceReferenciaAgendaIdToAgendas < ActiveRecord::Migration[5.0]
  def change
    add_reference :agendas, :referencia_agenda, foreign_key: true
  end
end
