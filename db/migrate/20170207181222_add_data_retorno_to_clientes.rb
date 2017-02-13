class AddDataRetornoToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :data_retorno, :date
  end
end
