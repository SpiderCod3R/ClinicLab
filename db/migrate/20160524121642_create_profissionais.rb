class CreateProfissionais < ActiveRecord::Migration
  def change
    create_table :profissionais do |t|
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

      t.timestamps null: false
    end
  end
end
