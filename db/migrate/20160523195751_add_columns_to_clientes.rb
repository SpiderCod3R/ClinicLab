class AddColumnsToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :sexo, :string
    add_column :clientes, :rg, :string
    add_column :clientes, :estado_civil, :string
  end
end
