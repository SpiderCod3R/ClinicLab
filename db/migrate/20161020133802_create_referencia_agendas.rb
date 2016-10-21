class CreateReferenciaAgendas < ActiveRecord::Migration[5.0]
  def change
    create_table :referencia_agendas do |t|
      t.string :descricao
      t.boolean :status
      t.belongs_to :profissional, foreign_key: true
      t.integer :empresa_id

      t.timestamps
    end
  end
end
