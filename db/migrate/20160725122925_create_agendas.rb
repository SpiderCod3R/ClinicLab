class CreateAgendas < ActiveRecord::Migration[5.0]
  def change
    create_table :agendas do |t|
      t.belongs_to :profissional, foreign_key: true
      t.belongs_to :empresa, foreign_key: true
      t.belongs_to :usuario, foreign_key: true
      t.date :data_inicial
      t.date :data_final
      t.boolean :atendimento_sabado
      t.boolean :atendimento_domingo
      t.boolean :horario_parcial
      t.string  :atendimento_duracao

      t.timestamps
    end
  end
end
