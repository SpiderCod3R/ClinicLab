class AddExtraFieldsToUsuarioPermissaoEmpresas < ActiveRecord::Migration
  def change
    unless column_exists? :usuario_permissao_empresas, :cadastrar
      add_column :usuario_permissao_empresas, :cadastrar, :boolean
    end

    unless column_exists? :usuario_permissao_empresas, :editar
      add_column :usuario_permissao_empresas, :editar, :boolean
    end

    unless column_exists? :usuario_permissao_empresas, :visualizar
      add_column :usuario_permissao_empresas, :visualizar, :boolean
    end

    unless column_exists? :usuario_permissao_empresas, :excluir
      add_column :usuario_permissao_empresas, :excluir, :boolean
    end
  end
end
