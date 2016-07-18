class AddFieldNomeToPermissaoEmpresas < ActiveRecord::Migration
  def change
    add_column :permissao_empresas, :nome, :string
  end
end
