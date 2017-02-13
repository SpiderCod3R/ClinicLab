class AddSetorToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :setor, :string
  end
end
