class AddObservacaoConvenioToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :observacao_convenio, :text
  end
end
