class AddSequenciaToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :sequencia, :integer
  end
end
