class CreateGclinicEnvironmentAccess < ActiveRecord::Migration[5.0]
  def change
    create_table :gclinic_environment_access do |t|
      t.integer :access_id
      t.integer :environment_id

      t.timestamps
    end
  end
end
