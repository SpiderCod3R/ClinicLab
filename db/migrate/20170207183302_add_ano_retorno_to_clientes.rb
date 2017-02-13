class AddAnoRetornoToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :ano_retorno, :string
  end
end
