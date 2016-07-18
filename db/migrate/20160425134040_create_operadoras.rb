class CreateOperadoras < ActiveRecord::Migration
  def change
    create_table :operadoras do |t|
      t.string :nome
      t.references :empresa

      t.timestamps null: false
    end
  end
end
