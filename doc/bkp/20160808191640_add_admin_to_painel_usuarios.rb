class AddAdminToPainelUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_column :painel_usuarios, :admin, :boolean
  end
end
