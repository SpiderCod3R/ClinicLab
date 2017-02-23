class CreatePainelEmpresaPermissoes < ActiveRecord::Migration[5.0]
  def change
    create_table :painel_empresa_permissoes do |t|
      t.integer :permissao_id
      t.integer :empresa_id

      t.timestamps
    end
  end
end
