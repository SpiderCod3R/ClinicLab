class AddPacienteFieldsToAgendaMovimentacoes < ActiveRecord::Migration[5.0]
  def change
    add_column :agenda_movimentacoes, :nome_paciente, :string
    add_column :agenda_movimentacoes, :telefone_paciente, :string
    add_column :agenda_movimentacoes, :email_paciente, :string
  end
end
