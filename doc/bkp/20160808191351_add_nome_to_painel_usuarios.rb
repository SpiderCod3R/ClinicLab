class AddNomeToPainelUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_column :painel_usuarios, :nome, :string
  end
end
