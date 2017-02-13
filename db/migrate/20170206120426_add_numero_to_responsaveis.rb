class AddNumeroToResponsaveis < ActiveRecord::Migration[5.0]
  def change
    add_column :responsaveis, :numero, :integer
  end
end
