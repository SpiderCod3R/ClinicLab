class AddLimiteValeToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :limite_vale, :float
  end
end
