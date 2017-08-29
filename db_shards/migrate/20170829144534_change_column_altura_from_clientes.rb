class ChangeColumnAlturaFromClientes < ActiveRecord::Migration[5.0]
  def up
    change_column :clientes, :altura, :string
    change_column :clientes, :peso, :string
  end

  def down
    change_column :clientes, :altura, :float
  end
end
