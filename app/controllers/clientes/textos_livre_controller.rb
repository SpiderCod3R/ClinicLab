class Clientes::TextosLivreController < Support::InsideController
  before_action :find_subject
  before_action :find_client_free_text
  respond_to :html, :js

  def edit
    respond_to &:js
  end

  def destroy
    if @cliente_texto_livre.destroy
      redirect_to :back
    end
  end

  private
    def find_client_free_text
      @cliente_texto_livre = @cliente.cliente_texto_livres.find(params[:cliente_texto_livre_id])
    end

    def find_subject
      @cliente = Cliente.find(params[:cliente_id])
    end
end
