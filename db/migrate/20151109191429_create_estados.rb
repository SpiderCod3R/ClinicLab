class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.string :sigla
      t.string :nome
      t.integer :capital_id

      t.timestamps null: false
    end
  end
end
