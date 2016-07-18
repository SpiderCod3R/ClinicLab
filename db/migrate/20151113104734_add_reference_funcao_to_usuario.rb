class AddReferenceFuncaoToUsuario < ActiveRecord::Migration
  def change
    add_reference :usuarios, :funcao, index: true, foreign_key: true
  end
end
