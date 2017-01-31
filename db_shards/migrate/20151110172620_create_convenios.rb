class CreateConvenios < ActiveRecord::Migration
  def change
    create_table :convenios do |t|
      t.string :nome
      t.decimal :valor, precision: 14, scale: 2
      t.boolean :status, default: true

      t.timestamps null: false
    end
  end
end
