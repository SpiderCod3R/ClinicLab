class AddBairroToResponsaveis < ActiveRecord::Migration[5.0]
  def change
    add_column :responsaveis, :bairro, :string
  end
end
