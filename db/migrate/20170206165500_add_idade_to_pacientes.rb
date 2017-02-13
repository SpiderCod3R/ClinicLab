class AddIdadeToPacientes < ActiveRecord::Migration[5.0]
  def change
    add_column :pacientes, :idade, :string
  end
end
