class CreateAgendas < ActiveRecord::Migration[5.0]
  def change
    create_table :agendas do |t|
      t.date    :data
      t.boolean :atendimento_sabado
      t.boolean :atendimento_domingo
      t.boolean :atendimento_parcial
      t.string  :atendimento_manha_duracao
      t.string  :atendimento_tarde_duracao

      t.belongs_to :profissional
      t.belongs_to :empresa
      t.belongs_to :usuario

      t.timestamps
    end
  end
end
