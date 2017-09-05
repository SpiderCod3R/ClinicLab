class RemoveForeingKey2FromClienteTextoLivres < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :cliente_texto_livres, name: "fk_rails_11761aae8e"
  end
end
