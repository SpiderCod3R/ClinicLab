class AddCelularToPacientes < ActiveRecord::Migration
  def change
    add_column :pacientes, :celular, :string
  end
end
