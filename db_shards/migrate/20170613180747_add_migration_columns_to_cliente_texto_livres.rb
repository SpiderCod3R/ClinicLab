class AddMigrationColumnsToClienteTextoLivres < ActiveRecord::Migration[5.0]
  def change
    add_column :cliente_texto_livres, :cabecalho, :string
    add_column :cliente_texto_livres, :usuario_id, :integer
  end
end
