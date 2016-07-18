class CreateAtendimentos < ActiveRecord::Migration
  def change
    create_table :atendimentos do |t|
      t.string :nome
      t.string :rg
      t.string :cpf
      t.string :data_nascimento
      t.string :telefone
      t.string :celular
      t.string :nome_da_mae
      t.string :endereco
      t.string :bairro
      t.belongs_to :cidade, index: true, foreign_key: true
      t.belongs_to :estado, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
