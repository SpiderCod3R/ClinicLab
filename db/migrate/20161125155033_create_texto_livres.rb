class CreateTextoLivres < ActiveRecord::Migration[5.0]
  def change
    create_table :texto_livres do |t|
      t.string :nome
      t.belongs_to :servico, foreign_key: true
      t.belongs_to :empresa
      t.text :content

      t.timestamps
    end
  end
end
