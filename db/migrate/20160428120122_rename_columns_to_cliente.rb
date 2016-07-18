class RenameColumnsToCliente < ActiveRecord::Migration
  def change
    rename_column :clientes, :uf, :estado_id
    rename_column :clientes, :cidade, :cidade_id
  end
end
