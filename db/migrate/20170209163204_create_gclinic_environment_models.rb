class CreateGclinicEnvironmentModels < ActiveRecord::Migration[5.0]
  def change
    create_table :gclinic_environment_models do |t|
      t.integer :environment_id
      t.integer :model_id

      t.timestamps
    end
  end
end
