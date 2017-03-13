class ClienteConveniosController < Support::AgendaSupportController
  def destroy
  end

  def update_convenio
    @cliente = Cliente.find(params[:cliente_id])
    @cliente_convenio = @cliente.cliente_convenios.find(params[:cliente_convenio_id])
    @cliente_convenio.update_attributes(convenio_id: params[:cliente_convenio_convenio_id],
                                        validade_carteira: params[:cliente_convenio_validade_carteira],
                                        produto: params[:cliente_convenio_produto],
                                        titular: params[:cliente_convenio_titular],
                                        titular: params[:cliente_convenio_titular],
                                        plano: params[:cliente_convenio_plano]
                                      )
  end

  def deactivate
    @cliente = Cliente.find(params[:cliente_id])
    @cliente_convenio = @cliente.cliente_convenios.find(params[:cliente_convenio_id])
    @cliente_convenio.status_convenio=  false
    @cliente_convenio.utilizando_agora= false
    @cliente_convenio.save
  end

  def activate
    @cliente = Cliente.find(params[:cliente_id])
    @cliente_convenio = @cliente.cliente_convenios.find(params[:cliente_convenio_id])
    @cliente_convenio.status_convenio= true
    @cliente_convenio.save
  end

  private
    def cliente_convenio_params
      params.require(:cliente_convenio).permit(:id,
                                               :cliente_id,
                                               :convenio_id,
                                               :status_convenio,
                                               :matricula,
                                               :plano,
                                               :validade_carteira,
                                               :produto,
                                               :titular,
                                               :utilizando_agora)
    end
end