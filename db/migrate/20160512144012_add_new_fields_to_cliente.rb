class AddNewFieldsToCliente < ActiveRecord::Migration
  def change
    add_column :clientes, :profissao, :string
    add_column :clientes, :email, :string
    add_column :clientes, :telefone, :string
  end
end
