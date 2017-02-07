class AddSpecFieldsToConvenios < ActiveRecord::Migration[5.0]
  def change
    add_column :convenios, :telefone, :string
    add_column :convenios, :endereco, :string
    add_column :convenios, :bairro, :string
    add_column :convenios, :cidade_id, :integer
    add_column :convenios, :estado_id, :integer
    add_column :convenios, :cep, :string
    add_column :convenios, :cnpj, :string
    add_column :convenios, :referencia, :string
    add_column :convenios, :registroons, :string
    add_column :convenios, :nundiasvalsenha, :string
    add_column :convenios, :sigla, :string
  end
end
