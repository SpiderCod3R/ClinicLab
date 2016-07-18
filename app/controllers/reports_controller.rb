class ReportsController < ApplicationController
    def relatorio_atendimento
      @relatorio = ConfiguracaoRelatorio.find_by(empresa_id: params[:empresa_id])
      @atendimento = Atendimento.retornar_objeto_pelo_id(params[:atendimento_id])
      respond_to do |format|
          format.html
          format.pdf do
              pdf = AtendimentoPacientePdf.new(@atendimento, @relatorio, "Boletim de Atendimento Médico")
              send_data pdf.render, filename: "atendimento_#{@atendimento.nome}", type: 'application/pdf', disposition: 'inline'
          end
      end
    end
end
