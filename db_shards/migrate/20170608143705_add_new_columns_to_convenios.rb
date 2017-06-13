class AddNewColumnsToConvenios < ActiveRecord::Migration[5.0]
  def change
    add_column :convenios, :contato, :string
    add_column :convenios, :matricula, :string
    add_column :convenios, :valorchconsulta, :decimal, :precision => 14, :scale => 2
    add_column :convenios, :valorchservico, :decimal, :precision => 14, :scale => 2
    add_column :convenios, :tipopessoa, :string
  end
end
