class CreatePermissaoEmpresas < ActiveRecord::Migration
  def change
    create_table :permissao_empresas do |t|
      t.string :modulo

      t.timestamps null: false
    end
  end
end
