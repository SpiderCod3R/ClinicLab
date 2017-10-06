class CreateSadtGrupos < ActiveRecord::Migration[5.0]
  def change
    create_table :sadt_grupos do |t|
      t.belongs_to :sadt
      t.belongs_to :grupo
      t.belongs_to :empresa

      t.timestamps
    end
  end
end
