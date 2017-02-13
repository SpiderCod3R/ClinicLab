class AddEmpresaIdToFornecedores < ActiveRecord::Migration[5.0]
  def change
    add_reference :fornecedores, :empresa, foreign_key: true
  end
end
