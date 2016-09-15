class Painel::AgendasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :find_empresa

  respond_to :html, :js, :json, :xml

  def index
    @agendas = Agenda.where(empresa_id: @empresa.id)
  end

  def new
    @agenda = Agenda.new
  end

  def create
    @agenda = Agenda.create_by_javascript_params(params[:agenda])
    respond_to &:json
  end

  private

    def find_empresa
      @empresa = Painel::Empresa.friendly.find(params[:empresa_id])
    end

    def agenda_params
      params.require(:agenda).permit(:id, :empresa_id, :profissional_id,
                                     :data, :atendimento_sabado,
                                     :atendimento_domingo, :atendimento_parcial,
                                     :atendimento_manha_duracao, :atendimento_tarde_duracao,
                                     :atendimento_inicio, :atendimento_final)
    end
end