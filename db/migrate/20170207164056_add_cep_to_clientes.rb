class AddCepToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :cep, :string
  end
end
