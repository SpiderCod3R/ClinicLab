class AddColumnNascimentoToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :nascimento, :date
  end
end
