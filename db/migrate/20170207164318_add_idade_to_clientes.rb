class AddIdadeToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :idade, :integer
  end
end
