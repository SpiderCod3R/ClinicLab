class RemoveColumnDataNascimentoFromAtendimentos < ActiveRecord::Migration
  def change
    remove_column :atendimentos, :data_nascimento, :string
  end
end
