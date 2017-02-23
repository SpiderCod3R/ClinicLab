class CreateClienteReceituarios < ActiveRecord::Migration[5.0]
  def change
    create_table :cliente_receituarios do |t|
      t.belongs_to :cliente, foreign_key: true
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end