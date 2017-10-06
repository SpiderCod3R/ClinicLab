class DropTableSadtExameProcedimentos < ActiveRecord::Migration[5.0]
  def change
    drop_table :sadt_exame_procedimentos, if_exists: true
  end
end
