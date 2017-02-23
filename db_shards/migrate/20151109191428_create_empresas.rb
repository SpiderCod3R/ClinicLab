class CreateEmpresas < ActiveRecord::Migration[5.0]
  def change
    create_table :empresas do |t|
      t.string :nome
      t.string :slug
      t.string :environment_name

      t.timestamps
    end
  end
end
