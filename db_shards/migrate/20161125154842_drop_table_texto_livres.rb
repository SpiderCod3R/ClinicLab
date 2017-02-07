class DropTableTextoLivres < ActiveRecord::Migration[5.0]
  def change
    drop_table 'texto_livres' if ActiveRecord::Base.connection.table_exists? 'texto_livres'
  end
end
