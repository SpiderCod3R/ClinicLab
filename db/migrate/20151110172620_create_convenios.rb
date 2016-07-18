class CreateConvenios < ActiveRecord::Migration
  def change
    create_table :convenios do |t|
      t.string :nome
      t.decimal :valor,:decimal,:decimal,  :precision => 14, :scale => 2

      t.timestamps null: false
    end
  end
end
