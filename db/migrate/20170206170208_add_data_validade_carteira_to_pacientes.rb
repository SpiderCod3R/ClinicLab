class AddDataValidadeCarteiraToPacientes < ActiveRecord::Migration[5.0]
  def change
    add_column :pacientes, :Data_VALIDADE_CARTEIRA, :date
  end
end
