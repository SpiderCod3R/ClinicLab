class AddSpecFieldsToClientes < ActiveRecord::Migration[5.0]
  def change
    add_column :clientes, :mes, :string
    add_column :clientes, :tipo_sanguineo, :string
    add_column :clientes, :data_da_ultima_consulta, :date
    add_column :clientes, :data_obito, :date
    add_column :clientes, :peso, :float
    add_column :clientes, :como_soube, :text
    add_column :clientes, :altura, :float
  end
end
