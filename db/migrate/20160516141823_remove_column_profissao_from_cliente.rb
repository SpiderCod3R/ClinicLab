class RemoveColumnProfissaoFromCliente < ActiveRecord::Migration
  def change
  	remove_column :clientes, :profissao, :string
  end
end
