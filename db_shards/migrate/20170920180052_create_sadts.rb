class CreateSadts < ActiveRecord::Migration[5.0]
  def change
    create_table :sadts do |t|
      t.text :indicacao_clinica
      t.date :data
      t.belongs_to :cliente
      t.belongs_to :empresa

      t.timestamps
    end
  end
end
