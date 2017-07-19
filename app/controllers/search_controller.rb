class SearchController < Support::InsideController
  def buscar_pacientes
    if params[:nome_paciente] != ""
      @clientes= Cliente.where("nome LIKE ?", "%#{params[:nome_paciente]}%").take(10)
    end
  end

  def find_cliente
    @cliente = Cliente.find(params[:id])
  end

  def find_cliente_convenio
    @cliente = Cliente.find(params[:cliente_id])
    @cliente_convenio = @cliente.cliente_convenios.find(params[:cliente_convenio_id])
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

  def find_texto_livre
    @texto_livre= TextoLivre.find(params[:id])
  end

  def find_cliente_receituario
    @receituario_cliente= ClienteReceituario.find_by( id: params[:id], cliente_id: params[:cliente_id])
  end
end
