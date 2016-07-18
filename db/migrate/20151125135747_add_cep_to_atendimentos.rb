class AddCepToAtendimentos < ActiveRecord::Migration
  def change
    add_column :atendimentos, :cep, :string
    add_column :pacientes, :cep, :string
  end
end
