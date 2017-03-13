class AddSalaEsperaToAgendaPermissoes < ActiveRecord::Migration[5.0]
  def change
    add_column :agenda_permissoes, :sala_espera, :boolean
  end
end
