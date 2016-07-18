class AddStatusToConvenios < ActiveRecord::Migration
  def change
    add_column :convenios, :status, :string
  end
end
