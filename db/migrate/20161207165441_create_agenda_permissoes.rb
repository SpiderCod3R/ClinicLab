class CreateAgendaPermissoes < ActiveRecord::Migration[5.0]
  def change
    create_table :agenda_permissoes do |t|
      t.references :usuario_permissoes
      t.boolean :agendar
      t.boolean :excluir
      t.boolean :trocar_horario
      t.boolean :realizar_atendimento
      t.boolean :visualizar_atendimento
      t.boolean :limpar_horario
      t.boolean :paciente_nao_veio
      t.boolean :remarcar_pelo_paciente
      t.boolean :remarcar_pelo_medico
      t.boolean :desmarcar_pelo_medico
      t.boolean :desmarcar_pelo_paciente

      t.timestamps
    end
  end
end
