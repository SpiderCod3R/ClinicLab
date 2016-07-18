class AddImagemToImagemCabec < ActiveRecord::Migration
  def change
    add_column :imagem_cabecs, :imagem, :string
  end
end
