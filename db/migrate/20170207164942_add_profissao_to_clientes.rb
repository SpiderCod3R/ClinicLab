class AddProfissaoToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :profissao, :string
  end
end
