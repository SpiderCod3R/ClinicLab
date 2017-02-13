class AddCorrespondenciaToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :correspondencia, :string
  end
end
