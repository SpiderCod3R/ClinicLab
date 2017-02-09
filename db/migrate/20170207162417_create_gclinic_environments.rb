class CreateGclinicEnvironments < ActiveRecord::Migration[5.0]
  def change
    create_table :gclinic_environments do |t|
      t.string :name
      t.string :database_name

      t.timestamps
    end
  end
end
