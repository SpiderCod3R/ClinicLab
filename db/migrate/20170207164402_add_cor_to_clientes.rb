class AddCorToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :cor, :string
  end
end
