class AddCodigoFieldToConvenios < ActiveRecord::Migration[5.0]
  def change
    add_column :convenios, :codigo, :integer
  end
end
