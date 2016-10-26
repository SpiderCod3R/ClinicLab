class AddColmunPeriodoToAgenda < ActiveRecord::Migration[5.0]
  def change
    add_column :agendas, :periodo, :string
  end
end
