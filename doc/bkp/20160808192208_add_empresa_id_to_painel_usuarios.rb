class AddEmpresaIdToPainelUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_column :painel_usuarios, :empresa_id, :integer
  end
end
