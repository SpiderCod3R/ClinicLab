class CreateReceituarios < ActiveRecord::Migration[5.0]
  def change
    create_table :receituarios do |t|
      t.string :nome
      t.string :slug
      t.text :receita
      t.belongs_to :empresa

      t.timestamps
    end
  end
end
