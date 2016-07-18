class CreateCargos < ActiveRecord::Migration
  def change
    create_table :cargos do |t|
      t.string :nome

      t.timestamps null: false
    end
  end
end
