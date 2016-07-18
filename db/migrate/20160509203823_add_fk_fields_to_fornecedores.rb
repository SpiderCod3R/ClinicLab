class AddFkFieldsToFornecedores < ActiveRecord::Migration
  def change
    add_reference :fornecedores, :estado, index: true, foreign_key: true
    add_reference :fornecedores, :cidade, index: true, foreign_key: true
  end
end
