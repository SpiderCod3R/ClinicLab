class ClienteConveniosController < ApplicationController
  def destroy
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
                                               :titular)
    end
end