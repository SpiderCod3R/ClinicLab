class CreateAgendaHorarioTardes < ActiveRecord::Migration[5.0]
  def change
    create_table :agenda_tarde_horarios do |t|
      t.belongs_to :agenda, foreign_key: true
      t.string :dia
      t.string :turno
      t.string :inicio_do_atendimento
      t.string :final_do_atendimento

      t.timestamps
    end
  end
end
