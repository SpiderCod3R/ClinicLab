class AddMigrationColumnsToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :cidade_old, :string
    add_column :clientes, :estado_old, :string
    add_column :clientes, :convenio, :string
    add_column :clientes, :matricula, :string
    add_column :clientes, :titular, :string
    add_column :clientes, :data_cadastro, :date
  end
end
