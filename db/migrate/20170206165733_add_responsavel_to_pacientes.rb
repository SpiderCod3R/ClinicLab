class AddResponsavelToPacientes < ActiveRecord::Migration[5.0]
  def change
    add_column :pacientes, :responsavel, :string
  end
end
