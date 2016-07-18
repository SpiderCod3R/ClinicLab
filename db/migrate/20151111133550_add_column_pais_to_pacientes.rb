class AddColumnPaisToPacientes < ActiveRecord::Migration
  def change
    add_column :pacientes, :localizacao, :string, default: "Brasil"
  end
end
