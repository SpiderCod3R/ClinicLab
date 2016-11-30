class CreateClienteTextoLivres < ActiveRecord::Migration[5.0]
  def change
    create_table :cliente_texto_livres do |t|
      t.belongs_to :cliente, foreign_key: true
      t.text :content_data
      t.belongs_to :texto_livre, foreign_key: true

      t.timestamps
    end
  end
end
