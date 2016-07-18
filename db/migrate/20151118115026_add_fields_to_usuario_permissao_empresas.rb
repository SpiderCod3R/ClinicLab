class AddFieldsToUsuarioPermissaoEmpresas < ActiveRecord::Migration
  def change
    add_column :usuario_permissao_empresas, :cadastrar, :boolean
    add_column :usuario_permissao_empresas, :editar, :boolean
    add_column :usuario_permissao_empresas, :visualizar, :boolean
    add_column :usuario_permissao_empresas, :excluir, :boolean
    remove_column :usuario_permissao_empresas, :permissao, :string
  end
end
