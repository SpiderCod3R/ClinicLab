class CreateImagemCabecs < ActiveRecord::Migration
  def change
    create_table :imagem_cabecs do |t|
      t.attachment :imagem
      t.string :imagem
      t.string :nome
      t.timestamps null: false
    end
  end
end
