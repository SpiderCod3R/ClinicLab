class AddStatusToCabec < ActiveRecord::Migration
  def change
    add_column :cabecs, :status, :string
  end
end
