class AddObsToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :observacoes, :text
  end
end
