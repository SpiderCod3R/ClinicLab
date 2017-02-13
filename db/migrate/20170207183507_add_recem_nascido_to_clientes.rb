class AddRecemNascidoToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :recem_nascido, :string
  end
end
