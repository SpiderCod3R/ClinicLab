class AddNewTabFieldsToCliente < ActiveRecord::Migration
  def change
    add_column :clientes, :status_convenio, :string
    add_column :clientes, :matricula, :string
    add_column :clientes, :plano, :string
    add_column :clientes, :validade_carteira, :string
    add_column :clientes, :produto, :string
    add_column :clientes, :titular, :string
    add_reference :clientes, :convenio, index: true, foreign_key: true
  end
end
