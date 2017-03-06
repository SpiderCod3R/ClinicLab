class CreateImagensExternas < ActiveRecord::Migration[5.0]
  def change
    create_table :imagens_externas do |t|
      t.attachment :foto_antes
      t.attachment :foto_depois
      t.belongs_to :cliente, foreign_key: true
      t.timestamps null: false
    end
  end
end
