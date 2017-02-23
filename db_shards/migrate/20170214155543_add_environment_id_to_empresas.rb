class AddEnvironmentIdToEmpresas < ActiveRecord::Migration[5.0]
  def change
    add_column :empresas, :environment_id, :integer
  end
end
