class AddAdminToGclinicUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :gclinic_users, :admin, :boolean
  end
end
