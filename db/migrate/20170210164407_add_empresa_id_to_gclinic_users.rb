class AddEmpresaIdToGclinicUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :gclinic_users, :empresa_id, :integer
  end
end
