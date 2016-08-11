class CreatePainelUsuarioPermissoes < ActiveRecord::Migration[5.0]
  def change
    create_table :painel_usuario_permissoes do |t|
      t.integer :usuario_id
      t.integer :permissao_id
      t.boolean :cadastrar
      t.boolean :atualizar
      t.boolean :exibir
      t.boolean :deletar

      t.timestamps
    end
  end
end
