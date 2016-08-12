class CreateCentroDeCustos < ActiveRecord::Migration
  def change
    create_table :centro_de_custos do |t|
      t.string :nome
      t.boolean :status, default: true

      t.timestamps null: false
    end
  end
end
