class AddColumnDataHoraToAtendimentos < ActiveRecord::Migration
  def change
    add_column :atendimentos, :data, :date
    add_column :atendimentos, :hora, :time
  end
end
