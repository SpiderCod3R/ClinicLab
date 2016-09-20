class AddAtendimentoInicioFinalToAgendas < ActiveRecord::Migration[5.0]
  def change
    add_column :agendas, :atendimento_inicio, :string
    add_column :agendas, :atendimento_final, :string
  end
end
