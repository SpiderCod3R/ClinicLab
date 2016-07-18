class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :status
      t.string :nome
      t.string :cpf
      t.string :endereco
      t.string :complemento
      t.string :bairro
      t.string :uf
      t.string :cidade

      t.timestamps null: false
    end
  end
end
