class CreateHistoricos < ActiveRecord::Migration[5.0]
  def change
    create_table :historicos do |t|
      t.text :indice
      t.string :idade
      t.belongs_to :cliente
      t.belongs_to :usuario
      
      t.timestamps null: false
    end
  end
end
