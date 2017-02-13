class AddHoraToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :hora, :string
  end
end
