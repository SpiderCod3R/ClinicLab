class AddNewerMigrationColumnsToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :flag, :string unless column_exists?(:clientes, :flag)
    add_column :clientes, :foto, :string unless column_exists?(:clientes, :foto)
    add_column :clientes, :atualizador, :string unless column_exists?(:clientes, :atualizador)
    add_column :clientes, :atualizador_historico, :string unless column_exists?(:clientes, :atualizador_historico)
    add_column :clientes, :hora_atualizacao, :string unless column_exists?(:clientes, :hora_atualizacao)
    add_column :clientes, :data_atualizacao_historico, :string unless column_exists?(:clientes, :data_atualizacao_historico)
    add_column :clientes, :hora_atualizacao_historico, :string unless column_exists?(:clientes, :hora_atualizacao_historico)
    add_column :clientes, :alertar_paciente, :string unless column_exists?(:clientes, :alertar_paciente)
  end
end
