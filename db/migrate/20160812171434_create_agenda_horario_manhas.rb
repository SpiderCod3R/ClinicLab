class CreateAgendaHorarioManhas < ActiveRecord::Migration[5.0]
  def change
    create_table :agenda_manha_horarios do |t|
      t.belongs_to :agenda
      t.string :dia
      t.string :turno
      t.string :inicio_do_atendimento
      t.string :final_do_atendimento

      t.timestamps
    end
  end
end
