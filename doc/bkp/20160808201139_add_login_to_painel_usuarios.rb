class AddLoginToPainelUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_column :painel_usuarios, :login, :string
  end
end
