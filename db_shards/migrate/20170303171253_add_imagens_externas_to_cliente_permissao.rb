class AddImagensExternasToClientePermissao < ActiveRecord::Migration[5.0]
  def change
    add_column :cliente_permissoes, :imagens_externas, :boolean
  end
end
