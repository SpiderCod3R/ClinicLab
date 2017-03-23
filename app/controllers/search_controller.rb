class SearchController < Support::InsideController
  def buscar_pacientes
    if params[:nome_paciente] != ""
      @clientes= current_user.empresa.clientes.where("nome LIKE ?", "%#{params[:nome_paciente]}%").take(10)
    end
  end

  def collect_all_free_text
    @textos_livres= current_user.empresa.texto_livres.all
  end

  def find_cliente_texto_livre
    @texto_livre= ClienteTextoLivre.find_by( id: params[:id], cliente_id: params[:cliente_id])
  end

  def find_receituario
    @receituario= Receituario.find(params[:id])
  end

  def find_cliente_receituario
    @receituario_cliente= ClienteReceituario.find_by( id: params[:id], cliente_id: params[:cliente_id])
  end
end
