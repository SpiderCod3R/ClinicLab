class AddHoraAtendimentoToAgendas < ActiveRecord::Migration[5.0]
  def change
    add_column :agendas, :hora_atendimento, :time
  end
end
