class AddColumnValorAtServico < ActiveRecord::Migration[5.0]
  def change
    add_column :servicos, :valor, :decimal, :precision => 14, :scale => 2
  end
end
