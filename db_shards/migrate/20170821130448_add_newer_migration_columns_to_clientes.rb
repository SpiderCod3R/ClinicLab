class AddNewerMigrationColumnsToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :flag, :string
    add_column :clientes, :foto, :string
    add_column :clientes, :atualizador, :string
    add_column :clientes, :atualizador_historico, :string
    add_column :clientes, :hora_atualizacao, :string
    add_column :clientes, :data_atualizacao_historico, :string
    add_column :clientes, :hora_atualizacao_historico, :string
    add_column :clientes, :alertar_paciente, :string
  end
end
