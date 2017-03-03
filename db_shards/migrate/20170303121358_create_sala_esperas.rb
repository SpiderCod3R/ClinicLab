class CreateSalaEsperas < ActiveRecord::Migration[5.0]
  def change
    create_table :sala_esperas do |t|
      t.belongs_to :cliente, foreign_key: true
      t.belongs_to :agenda, foreign_key: true
      t.belongs_to :referencia_agenda, foreign_key: true
      t.date :data
      t.string :status
      t.string :hora_agendada
      t.string :hora_chegada
      t.string :hora_inicio_atendimento
      t.string :hora_fim_atendimento

      t.timestamps
    end
  end
end
