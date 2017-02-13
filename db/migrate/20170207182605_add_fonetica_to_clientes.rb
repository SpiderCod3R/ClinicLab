class AddFoneticaToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :fonetica, :string
  end
end
