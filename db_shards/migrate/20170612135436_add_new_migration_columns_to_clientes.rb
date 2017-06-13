class AddNewMigrationColumnsToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :alertar, :string
    add_column :clientes, :historico, :text
    add_column :clientes, :plano, :string
    add_column :clientes, :atendente, :string
    add_column :clientes, :data_atualizacao, :date
  end
end
