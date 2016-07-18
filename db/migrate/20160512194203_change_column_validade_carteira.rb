class ChangeColumnValidadeCarteira < ActiveRecord::Migration
  def change
    change_column :clientes, :validade_carteira,  :date
  end
end
