class CreateGrupos < ActiveRecord::Migration[5.0]
  def change
    create_table :grupos do |t|
      t.string :nome
      t.belongs_to :empresa

      t.timestamps
    end
  end
end
