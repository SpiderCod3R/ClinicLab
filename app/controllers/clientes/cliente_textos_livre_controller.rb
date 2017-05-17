class Clientes::ClienteTextosLivreController < Support::InsideController
  before_action :find_subject
  respond_to :html, :js

  def edit
    @cliente_texto_livre = @cliente.cliente_texto_livres.find(params[:cliente_texto_livre_id])
    respond_to &:js
  end

  private
    def find_subject
      @cliente = Cliente.find(params[:cliente_id])
    end
end
