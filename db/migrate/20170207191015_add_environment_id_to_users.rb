class AddEnvironmentIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :gclinic_users, :environment_id, :integer
  end
end
