class CreateServicos < ActiveRecord::Migration[5.0]
  def change
    create_table :servicos do |t|
      t.string :tipo
      t.string :abreviatura
      t.references :empresa

      t.timestamps
    end
  end
end
