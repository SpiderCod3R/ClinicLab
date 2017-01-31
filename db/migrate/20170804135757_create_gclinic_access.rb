class CreateGclinicAccess < ActiveRecord::Migration[5.0]
  def change
    create_table :gclinic_access do |t|
      t.string :name
      t.string :model_class

      t.timestamps
    end
  end
end
