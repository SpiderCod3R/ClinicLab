class AddDataUltimoServicoToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :data_ultimo_servico, :date
  end
end
