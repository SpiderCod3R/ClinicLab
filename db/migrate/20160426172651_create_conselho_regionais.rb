class CreateConselhoRegionais < ActiveRecord::Migration
  def change
    create_table :conselho_regionais do |t|
      t.string :sigla
      t.text :descricao
      t.boolean :status, default: true

      t.timestamps null: false
    end
  end
end
