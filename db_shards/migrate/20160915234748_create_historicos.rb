class CreateHistoricos < ActiveRecord::Migration[5.0]
  def change
    create_table :historicos do |t|
      t.text :indice
      t.references :cliente, foreign_key: true
      t.string :idade
      t.integer :usuario_id

      t.timestamps null: false
    end
  end
end
