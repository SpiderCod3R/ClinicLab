class AddEmpresaToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :empresa, :string
  end
end
