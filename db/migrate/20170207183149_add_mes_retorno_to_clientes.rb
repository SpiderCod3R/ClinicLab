class AddMesRetornoToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :mes_retorno, :string
  end
end
