class CreateFornecedores < ActiveRecord::Migration
  def change
    create_table :fornecedores do |t|
      t.string :status
      t.string :nome
      t.string :cpf
      t.string :cnpj
      t.string :email
      t.string :telefone
      t.string :celular
      t.string :endereco
      t.string :complemento
      t.string :bairro
      t.belongs_to :estado, index: true, foreign_key: true
      t.belongs_to :cidade, index: true, foreign_key: true
      t.string :documento

      t.timestamps null: false
    end
  end
end
