class CreateFeriadoEDataComemorativas < ActiveRecord::Migration[5.0]
  def change
    create_table :feriado_e_data_comemorativas do |t|
      t.date :data
      t.string :descricao

      t.timestamps
    end
  end
end
