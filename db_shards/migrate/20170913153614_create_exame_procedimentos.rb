class CreateExameProcedimentos < ActiveRecord::Migration[5.0]
  def change
    create_table :exame_procedimentos do |t|
      t.text :descricao
      t.string :tabela, :limit => 2
      t.string :codigo_procedimento, :limit => 10
      t.belongs_to :empresa

      t.timestamps
    end
  end
end
