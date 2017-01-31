class AddLoginToGclinicAdmins < ActiveRecord::Migration[5.0]
  def change
    add_column :gclinic_admins, :username, :string
  end
end
