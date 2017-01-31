class AddNomeAdminEnvironmentToPainelUsuarios < ActiveRecord::Migration[5.0]
  def change
    add_column :gclinic_usuarios, :username, :string
    add_column :gclinic_usuarios, :admin, :boolean
    add_column :gclinic_usuarios, :environment_id, :integer
  end
end
