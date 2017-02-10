class CreateUserModels < ActiveRecord::Migration[5.0]
  def change
    create_table :gclinic_user_models do |t|
      t.integer :user_id
      t.integer :model_id
      t.boolean :cadastrar
      t.boolean :atualizar
      t.boolean :exibir
      t.boolean :deletar

      t.timestamps
    end
  end
end
