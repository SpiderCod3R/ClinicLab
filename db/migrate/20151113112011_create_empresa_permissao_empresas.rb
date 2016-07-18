class CreateEmpresaPermissaoEmpresas < ActiveRecord::Migration
  def change
    create_table :empresa_permissao_empresas do |t|
      t.belongs_to :empresa, index: true, foreign_key: true
      t.belongs_to :permissao_empresa, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
