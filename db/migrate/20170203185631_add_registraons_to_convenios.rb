class AddRegistraonsToConvenios < ActiveRecord::Migration[5.0]
  def change
    add_column :convenios, :registraons, :string
  end
end
