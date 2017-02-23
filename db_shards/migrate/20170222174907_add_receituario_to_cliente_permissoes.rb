class AddReceituarioToClientePermissoes < ActiveRecord::Migration[5.0]
  def change
    add_column :cliente_permissoes, :receituario, :boolean
  end
end
