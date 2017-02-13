class AddDataValidadeCarteiraToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :data_validade_carteira, :date
  end
end
