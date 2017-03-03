class SalaDeEsperaController  < Support::InsideController

  def new
    # binding.pry
    if !params[:cliente_id].present?
      flash[:alert] = "Por-favor preencha todos os dados do cliente"
      redirect_to empresa_clinic_sheet_cliente_path(params[:empresa_id], agenda_id: params[:agenda_id])
    end
  end
end
