class AddObservacaoToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :observacao, :string
  end
end
