class CreateFuncoes < ActiveRecord::Migration
  def change
    create_table :funcoes do |t|
      t.string :nome
      t.string :descricao

      t.timestamps null: false
    end
  end
end
