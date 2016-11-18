class Support::ClienteSupportController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  before_action :set_estados, only: [:new, :edit, :create, :update, :ficha, :ficha_em_branco]

  def ficha
    @agenda = Agenda.find(params[:agenda_id])
    @cliente = current_usuario.empresa.clientes.build
    # @cliente.recupera_agenda_dados(@agenda)
    render :ficha_em_branco
  end

  def ficha_em_branco
    #only_partial
  end

  def change_or_create_new_paciente
    
  end


  private

    def set_estados
      @estados = Estado.pelo_nome
    end

    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    def cliente_params
      params.require(:cliente).permit(
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
        :estado_civil
        )
    end
end