class SalaDeEsperaController  < Support::InsideController

  # => Move cliente agendado para a sala de espera
  def new
    if !params[:cliente_id].present?
      flash[:alert] = "Por-favor preencha todos os dados do cliente"
      redirect_to empresa_clinic_sheet_cliente_path(params[:empresa_id], agenda_id: params[:agenda_id])
    else
      @agenda = Agenda.find(params[:agenda_id])
      @cliente = Cliente.find(params[:cliente_id])
      hora_agendada = DateTime.parse(@agenda.atendimento_inicio)
      @sala_de_espera = SalaEspera.new(agenda_id: params[:agenda_id], cliente_id: params[:cliente_id], data: @agenda.data, status: "ESPERA", hora_agendada: hora_agendada.strftime("%H:%M"), hora_chegada: DateTime.now)
      @agenda.status="ESPERA"
      @agenda.agenda_movimentacao.confirmacao="ESPERA"
      @agenda.agenda_movimentacao.save
      @agenda.save
      @sala_de_espera.save
      flash[:info] = "O cliente #{@cliente.nome} foi para a sala de espera"
      redirect_to empresa_agendas_path(current_user.empresa)
    end
  end

  # => Remove status de ESPERA e volta para a agenda como Agendado
  def back
    @agenda = Agenda.find(params[:agenda_id])
    @sala_de_espera = @agenda.sala_de_esperas.find(params[:id])
    @cliente = Cliente.find(@sala_de_espera.cliente)
    @agenda.status= I18n.t("agendas.helpers.scheduled")
    @agenda.agenda_movimentacao.confirmacao= I18n.t("agendas.helpers.scheduled")
    @agenda.agenda_movimentacao.save
    @agenda.save
    @sala_de_espera.destroy

    flash[:info] = "O cliente #{@cliente.nome} saiu da sala de espera"
    redirect_to empresa_agendas_path(current_user.empresa)
  end

  # => Realizar atendimento com o cliente na sala de espera
  def attended
    @agenda = Agenda.find(params[:agenda_id])
    @sala_de_espera = @agenda.sala_de_esperas.find(params[:id])
    @agenda.agenda_movimentacao.update_attributes(confirmacao: "ATD")
    @agenda.status=(I18n.t('agendas.helpers.attended'))
    @sala_de_espera.hora_fim_atendimento = DateTime.now
    @sala_de_espera.status=(I18n.t('agendas.helpers.attended'))
    @sala_de_espera.save
    redirect_to empresa_agendas_path(current_user.empresa)
  end
end
