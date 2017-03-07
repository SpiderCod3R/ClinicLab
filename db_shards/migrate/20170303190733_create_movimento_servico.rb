class CreateMovimentoServico < ActiveRecord::Migration[5.0]
  def change
    create_table :movimento_servicos do |t|
      t.integer :atendente_id
      t.integer :atualizador_id
      t.belongs_to :cliente, foreign_key: true
      t.belongs_to :convenio, foreign_key: true
      t.integer :solicitante_id
      t.integer :medico_id
      t.date :data_entrada
      t.time :hora_entrada
      t.decimal :valor_total, :precision => 14, :scale => 2
      t.belongs_to :empresa

      t.timestamps null: false
    end
  end
end
