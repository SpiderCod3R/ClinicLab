class AddColumnDescontoAtMovimentoServico < ActiveRecord::Migration[5.0]
  def change
    add_column :movimento_servicos, :valor_desconto, :decimal, :precision => 14, :scale => 2
  end
end
