class CreateAgendaMovimentacoes < ActiveRecord::Migration[5.0]
  def change
    create_table   :agenda_movimentacoes do |t|
      t.belongs_to :agenda, foreign_key: true
      t.belongs_to :convenio, foreign_key: true
      t.belongs_to :cliente, foreign_key: true
      t.text       :observacoes
      t.string     :confirmacao
      t.boolean    :sem_convenio
      t.date       :data
      t.time       :hora
      t.time       :hora_chegada
      t.string     :sala_espera
      t.date       :data_sala_espera
      t.integer    :atendente_id
      t.integer    :solicitante_id
      t.string     :nome_paciente
      t.string     :telefone_paciente
      t.string     :email_paciente

      t.timestamps
    end
  end
end
