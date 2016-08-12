class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.attachment :foto
      t.string :status
      t.string :nome
      t.string :cpf
      t.string :endereco
      t.string :complemento
      t.string :bairro
      t.string :email
      t.string :telefone
      t.string :sexo
      t.string :rg
      t.string :estado_civil
      t.date :nascimento

      t.string :produto
      t.string :status_convenio
      t.string :matricula
      t.string :titular
      t.string :plano
      t.date   :validade_carteira


      t.belongs_to :estado, index: true, foreign_key: true
      t.belongs_to :cidade, index: true, foreign_key: true
      t.belongs_to :cargo, index: true, foreign_key: true
      t.belongs_to :convenio, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
