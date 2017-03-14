class AddColumnValorServicosAtMovimentoServico < ActiveRecord::Migration[5.0]
  def change
    add_column :movimento_servicos, :valor_servicos, :decimal, :precision => 14, :scale => 2
  end
end
