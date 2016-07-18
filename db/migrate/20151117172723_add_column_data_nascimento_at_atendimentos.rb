class AddColumnDataNascimentoAtAtendimentos < ActiveRecord::Migration
  def change
    add_column :atendimentos, :data_nascimento, :date
  end
end
