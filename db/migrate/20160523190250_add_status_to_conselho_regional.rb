class AddStatusToConselhoRegional < ActiveRecord::Migration
  def change
    add_column :conselho_regionais, :status, :string
  end
end
