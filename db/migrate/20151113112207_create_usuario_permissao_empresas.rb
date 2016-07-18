class CreateUsuarioPermissaoEmpresas < ActiveRecord::Migration
  def change
    create_table :usuario_permissao_empresas do |t|
      t.belongs_to :usuario, index: true, foreign_key: true
      t.belongs_to :permissao_empresa, index: true, foreign_key: true
      t.string :permissao

      t.timestamps null: false
    end
  end
end
