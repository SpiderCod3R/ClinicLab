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
      t.string :estado
      t.string :cidade

      t.timestamps null: false
    end
  end
end
