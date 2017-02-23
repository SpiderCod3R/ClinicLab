class RemoveConvenioFieldsFromClientes < ActiveRecord::Migration[5.0]
  def change
    if column_exists?(:clientes, :convenio_id)
      remove_foreign_key :clientes, :convenios
      remove_column :clientes, :convenio_id
    end
    if column_exists?(:clientes, :status_convenio)
      remove_column :clientes, :status_convenio
    end
    if column_exists?(:clientes, :matricula)
      remove_column :clientes, :matricula
    end
    if column_exists?(:clientes, :titular)
      remove_column :clientes, :titular
    end
    if column_exists?(:clientes, :plano)
      remove_column :clientes, :plano
    end
    if column_exists?(:clientes, :validade_carteira)
      remove_column :clientes, :validade_carteira
    end
    if column_exists?(:clientes, :produto)
      remove_column :clientes, :produto
    end
  end
end
