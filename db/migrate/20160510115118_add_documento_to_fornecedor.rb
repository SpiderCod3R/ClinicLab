class AddDocumentoToFornecedor < ActiveRecord::Migration
  def change
    add_column :fornecedores, :documento, :string
  end
end
