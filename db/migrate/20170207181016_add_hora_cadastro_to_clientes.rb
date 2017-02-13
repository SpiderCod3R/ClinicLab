class AddHoraCadastroToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :hora_cadastro, :string
  end
end
