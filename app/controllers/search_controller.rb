class SearchController < ApplicationController
  skip_authorize_resource
  def buscar_pacientes
    if params[:nome_paciente] != ""
      @pacientes = Cliente.where("nome LIKE ?", "#{params[:nome_paciente]}%").where(empresa_id: current_usuario.empresa_id).take(10)
    end
  end

  def collect_all_free_text
    @textos_livres = TextoLivre.all.where(empresa_id: current_usuario.empresa_id)
  end

  def find_cliente_texto_livre
    @texto_livre= ClienteTextoLivre.find_by( id: params[:id], cliente_id: params[:cliente_id])
  end
end
