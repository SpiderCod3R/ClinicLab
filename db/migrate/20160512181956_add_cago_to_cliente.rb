class AddCagoToCliente < ActiveRecord::Migration
  def change
    add_reference :clientes, :cargo, index: true, foreign_key: true
  end
end
