class CreatePacientes < ActiveRecord::Migration
  def change
    create_table :pacientes do |t|
      t.string :nome
      t.string :rg
      t.string :cpf
      t.date :data_nascimento
      t.string :telefone
      t.string :nome_da_mae
      t.string :endereco
      t.string :bairro

      t.timestamps null: false
    end
  end
end
