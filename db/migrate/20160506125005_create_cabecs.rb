class CreateCabecs < ActiveRecord::Migration
  def change
    create_table :cabecs do |t|
      t.string :nome
      t.text :texto

      t.timestamps null: false
    end
  end
end
