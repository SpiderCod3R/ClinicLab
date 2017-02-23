class ChangeColumnUsuarioPermissoesIdAtAgendaPermissoesToUserModelId < ActiveRecord::Migration[5.0]
  def change
    rename_column :agenda_permissoes, :usuario_permissoes_id, :user_model_id
  end
end
