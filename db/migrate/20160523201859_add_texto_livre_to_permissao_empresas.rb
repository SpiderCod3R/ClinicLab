class AddTextoLivreToPermissaoEmpresas < ActiveRecord::Migration
  def change
  	PermissaoEmpresa.create(nome: "Texto Livre", modulo: "TextoLivre")
  end
end
