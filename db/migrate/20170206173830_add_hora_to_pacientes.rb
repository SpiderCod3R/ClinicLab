class AddHoraToPacientes < ActiveRecord::Migration[5.0]
  def change
    add_column :pacientes, :hora_cadastro, :string
  end
end
