class ClienteConveniosController < ApplicationController
  def destroy
  end

  def deactivate
    @cliente = Cliente.find(params[:cliente_id])
    @cliente_convenio = @cliente.cliente_convenios.find(params[:cliente_convenio_id])
    @cliente_convenio.status_convenio= false
    @cliente_convenio.utilizando_agora= false
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