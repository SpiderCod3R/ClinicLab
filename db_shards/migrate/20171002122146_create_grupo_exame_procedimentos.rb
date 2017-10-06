class CreateGrupoExameProcedimentos < ActiveRecord::Migration[5.0]
  def change
    create_table :grupo_exame_procedimentos do |t|
      t.belongs_to :grupo
      t.belongs_to :exame_procedimento
      t.belongs_to :empresa

      t.timestamps
    end
  end
end
