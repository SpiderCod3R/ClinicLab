class SalaDeEsperaController  < Support::InsideController

  def new
    # binding.pry
    if !params[:cliente_id].present?
      flash[:alert] = "Por-favor preencha todos os dados do cliente"
      redirect_to empresa_clinic_sheet_cliente_path(params[:empresa_id], agenda_id: params[:agenda_id])
    else
      @agenda = Agenda.find(params[:agenda_id])
      @sala_de_espera = @agenda.sala_de_esperas.build(cliente_id: params[:cliente_id], referencia_agenda_id: @agenda.referencia_agenda, data: @agenda.agenda_movimentacao.data, status: "ESPERA", hora_agendada: @agenda.atendimento_inicio, hora_inicio_atendimento: Time.now)
      @agenda.update_attributes(status: "ESPERA")
      @sala_de_espera.save
    end

  end
end