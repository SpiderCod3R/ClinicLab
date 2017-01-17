class CreateClientePermissoes < ActiveRecord::Migration[5.0]
  def change
    create_table :cliente_permissoes do |t|
      t.integer :usuario_permissoes_id
      t.boolean :historico
      t.boolean :texto_livre
      t.boolean :pdf_upload
      t.belongs_to :empresa

      t.timestamps
    end
  end
end
