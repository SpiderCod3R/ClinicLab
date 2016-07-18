class AddColumnNomeToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :nome, :string
  end
end
