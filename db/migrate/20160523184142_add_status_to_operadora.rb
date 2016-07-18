class AddStatusToOperadora < ActiveRecord::Migration
  def change
    add_column :operadoras, :status, :string
  end
end
