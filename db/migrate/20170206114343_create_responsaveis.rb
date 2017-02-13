class CreateResponsaveis < ActiveRecord::Migration[5.0]
  def change
    create_table :responsaveis do |t|
      t.string :nome
      t.string :endereco
      t.string :cidade_id
      t.string :estado_id
      t.string :cep
      t.string :telefone
      t.string :cpf
      t.string :crm
      t.string :observacao
      t.string :siglaconselho
      t.string :ufcrm
      t.string :cbos
      t.string :complementos
      t.boolean :status

      t.belongs_to :estado, index: true, foreign_key: true
      t.belongs_to :cidade, index: true, foreign_key: true

      t.timestamps 
    end
  end
end
