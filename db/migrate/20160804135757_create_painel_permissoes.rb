class CreatePainelPermissoes < ActiveRecord::Migration[5.0]
  def change
    create_table :painel_permissoes do |t|
      t.string :nome
      t.string :model_class

      t.timestamps
    end
  end
end
