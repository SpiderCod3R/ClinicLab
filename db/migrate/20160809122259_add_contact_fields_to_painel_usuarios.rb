class AddContactFieldsToPainelUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_column :painel_usuarios, :telefone, :string
    add_column :painel_usuarios, :codigo_pais, :integer
  end
end
