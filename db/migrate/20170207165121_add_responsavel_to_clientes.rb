class AddResponsavelToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :responsavel, :string
  end
end
