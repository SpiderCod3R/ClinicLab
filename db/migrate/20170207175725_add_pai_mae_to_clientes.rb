class AddPaiMaeToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :pai, :string
    add_column :clientes, :mae, :string
  end
end
