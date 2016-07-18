class CreateTextoLivres < ActiveRecord::Migration
  def change
    create_table :texto_livres do |t|
      t.string :nome
      t.text :texto

      t.timestamps null: false
    end
  end
end
