class AddNumdiasvalsenhaToConvenios < ActiveRecord::Migration[5.0]
  def change
    add_column :convenios, :numdiasvalsenha, :integer
  end
end
