class AddMigrationColumnsToClienteReceituarios < ActiveRecord::Migration[5.0]
  def change
    add_column :cliente_receituarios, :cabecalho, :string
    add_column :cliente_receituarios, :receitas, :string
  end
end
