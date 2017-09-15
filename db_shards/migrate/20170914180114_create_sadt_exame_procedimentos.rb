class CreateSadtExameProcedimentos < ActiveRecord::Migration[5.0]
  def change
    create_table :sadt_exame_procedimentos do |t|
      t.belongs_to :sadt
      t.belongs_to :exame_procedimento
      t.belongs_to :empresa

      t.timestamps
    end
  end
end
