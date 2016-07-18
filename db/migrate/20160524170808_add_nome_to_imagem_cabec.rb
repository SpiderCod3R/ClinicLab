class AddNomeToImagemCabec < ActiveRecord::Migration
  def change
    add_column :imagem_cabecs, :nome, :string
  end
end
