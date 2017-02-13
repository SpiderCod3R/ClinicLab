class AddMotivoRetornoToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :motivo_retorno, :string
  end
end
