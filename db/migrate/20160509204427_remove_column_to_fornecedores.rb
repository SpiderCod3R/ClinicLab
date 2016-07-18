class RemoveColumnToFornecedores < ActiveRecord::Migration
  def change
    remove_column :fornecedores, :cidade, :string
    remove_column :fornecedores, :estado, :string
  end
end
