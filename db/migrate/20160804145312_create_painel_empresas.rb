class CreatePainelEmpresas < ActiveRecord::Migration[5.0]
  def change
    create_table :painel_empresas do |t|
      t.string :nome
      t.boolean :status

      t.timestamps
    end
  end
end
