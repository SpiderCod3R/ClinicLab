class AddColumnAtivoToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :ativo, :boolean, default: true
  end
end
