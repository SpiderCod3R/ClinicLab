class ChangeColumnStatusConvenioAtClientes < ActiveRecord::Migration[5.0]
  def change
     change_column :clientes, :status_convenio, :boolean
     change_column :clientes, :status, :boolean
  end
end
