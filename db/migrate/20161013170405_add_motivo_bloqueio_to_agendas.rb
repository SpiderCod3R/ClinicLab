class AddMotivoBloqueioToAgendas < ActiveRecord::Migration[5.0]
  def change
    add_column :agendas, :motivo_bloqueio, :text
  end
end
