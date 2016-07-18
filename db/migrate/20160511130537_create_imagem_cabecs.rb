class CreateImagemCabecs < ActiveRecord::Migration
  def change
    create_table :imagem_cabecs do |t|

      t.timestamps null: false
    end
  end
end
