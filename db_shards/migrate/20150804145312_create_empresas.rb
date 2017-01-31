class CreatePainelEmpresas < ActiveRecord::Migration[5.0]
  def change
    create_table :empresas do |t|
      t.string :nome
      t.boolean :status
      t.string  :slug

      t.timestamps
    end

    add_index :painel_empresas, :slug, :unique => true
  end
end
