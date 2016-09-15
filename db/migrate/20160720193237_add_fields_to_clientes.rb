class AddFieldsToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :nacionalidade, :string
    add_column :clientes, :naturalidade, :string
  end
end
