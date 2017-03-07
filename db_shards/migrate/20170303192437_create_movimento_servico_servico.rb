class CreateMovimentoServicoServico < ActiveRecord::Migration[5.0]
  def change
    create_table :movimento_servico_servicos do |t|
      t.belongs_to :servico, foreign_key: true
      t.belongs_to :movimento_servico, foreign_key: true
      t.decimal :valor_servico, :precision => 14, :scale => 2
      t.belongs_to :empresa

      t.timestamps null: false
    end
  end
end
