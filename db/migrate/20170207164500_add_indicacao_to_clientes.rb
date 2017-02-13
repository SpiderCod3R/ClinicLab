class AddIndicacaoToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :indicacao, :string
  end
end
