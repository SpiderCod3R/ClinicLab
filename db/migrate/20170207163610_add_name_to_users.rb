class AddNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :gclinic_users, :name, :string
  end
end
