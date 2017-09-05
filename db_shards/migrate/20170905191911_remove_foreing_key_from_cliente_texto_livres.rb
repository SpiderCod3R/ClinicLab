class RemoveForeingKeyFromClienteTextoLivres < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :cliente_texto_livres, name: "fk_rails_287c754ebb"
  end
end
