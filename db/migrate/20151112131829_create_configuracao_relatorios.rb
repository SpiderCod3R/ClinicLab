class CreateConfiguracaoRelatorios < ActiveRecord::Migration
  def change
    create_table :configuracao_relatorios do |t|
      t.attachment :logo
      t.string :nome_empresa
      t.string :cnpj
      t.string :telefone
      t.string :endereco
      t.string :bairro
      t.string :cidade_estado
      t.string :email

      t.timestamps null: false
    end
  end
end
