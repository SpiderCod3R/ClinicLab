class CreateProfissionais < ActiveRecord::Migration
  def change
    create_table :profissionais do |t|
      t.attachment :imagem
      t.string :nome
      t.string :endereco
      t.string :complemento
      t.string :bairro
      t.string :status
      t.string :rg
      t.string :cpf
      t.string :telefone
      t.string :celular
      t.date   :data_nascimento


      t.belongs_to :cargo, index: true, foreign_key: true
      t.belongs_to :conselho_regional, index: true, foreign_key: true
      t.belongs_to :cidade, index: true, foreign_key: true
      t.belongs_to :estado, index: true, foreign_key: true
      t.belongs_to :operadora, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
