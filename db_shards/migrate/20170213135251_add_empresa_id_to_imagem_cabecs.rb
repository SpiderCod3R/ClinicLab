class AddEmpresaIdToImagemCabecs < ActiveRecord::Migration[5.0]
  def change
    add_reference :imagem_cabecs, :empresa, foreign_key: true
  end
end
