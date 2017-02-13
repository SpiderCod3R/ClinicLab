class AddDiaVencimentoConvenio1ToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :dia_vencimento_convenio, :date
  end
end
