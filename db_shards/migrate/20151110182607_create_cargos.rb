class CreateCargos < ActiveRecord::Migration
  def change
    create_table :cargos do |t|
      t.string :nome
      t.boolean :status, default: true

      t.timestamps null: false
    end
  end
end
