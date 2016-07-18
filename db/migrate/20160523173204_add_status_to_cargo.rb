class AddStatusToCargo < ActiveRecord::Migration
  def change
    add_column :cargos, :status, :string
  end
end
