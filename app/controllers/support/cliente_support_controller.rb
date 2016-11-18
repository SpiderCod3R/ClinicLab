class Support::ClienteSupportController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  before_action :set_estados, only: [:new, :edit, :create, :update, :ficha, :ficha_em_branco]

  def ficha
    session[:agenda_id] = params[:agenda_id]
    @cliente = current_usuario.empresa.clientes.build
    # @cliente.recupera_agenda_dados(@agenda)
    render :ficha_em_branco
  end

  def ficha_em_branco
    #only_partial
  end

  def change_or_create_new_paciente
    @agenda = Agenda.find(session[:agenda_id])

    if params[:cliente][:id].present?
      @cliente = Cliente.find(params[:cliente][:id])
      @cliente.update(params[:cliente])
    else
      @cliente = current_usuario.empresa.clientes.build(cliente_params)
      @cliente.save
    end

    @agenda.agenda_movimentacao.update_attributes(nome_paciente: @cliente.nome,
                                                  telefone_paciente: @cliente.telefone,
                                                  email_paciente: @cliente.email,
                                                  convenio_id: @cliente.convenio_id
                                                  )
    redirect_to painel_empresa_agenda_path(current_usuario.empresa, @agenda)
  end


  private

    def set_estados
      @estados = Estado.pelo_nome
    end

    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    def set_historico
      @historico = Historico.find(params[:historico_id])
    end

    def get_historicos
      @cliente ||= Cliente.find(session[:cliente_id])
      @historicos = Historico.where(cliente_id: @cliente.id).order('updated_at DESC')
    end

    def cliente_params
      params.require(:cliente).permit(:id,
                                      :status,
                                      :nome,
                                      :cpf,
                                      :endereco,
                                      :complemento,
                                      :bairro,
                                      :estado_id,
                                      :cidade_id,
                                      :empresa_id,
                                      :foto,
                                      :email,
                                      :telefone,
                                      :cargo_id,
                                      :status_convenio,
                                      :matricula,
                                      :plano,
                                      :validade_carteira,
                                      :produto,
                                      :titular,
                                      :convenio_id,
                                      :nascimento,
                                      :sexo,
                                      :rg,
                                      :estado_civil,
                                      :nacionalidade,
                                      :naturalidade,
                                      historico_attributes: [:indice, :idade, :usuario_id, :cliente_id]
                                      )
    end
end