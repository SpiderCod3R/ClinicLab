class CreatePacientes < ActiveRecord::Migration
  def change
    create_table :pacientes do |t|
      t.string :nome
      t.string :rg
      t.string :cpf
      t.date :data_nascimento
      t.string :telefone
      t.string :celular
      t.string :nome_da_mae
      t.string :endereco
      t.string :localizacao, default: "Brasil"
      t.belongs_to :estado, index: true, foreign_key: true
      t.belongs_to :cidade, index: true, foreign_key: true
      t.string :bairro
      t.string :cep

      t.timestamps null: false
    end
  end
end
