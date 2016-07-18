class SearchController < ApplicationController
  skip_authorize_resource
  def buscar_pacientes
    if params[:nome_paciente]  != ""
      @pacientes = Paciente.where("nome LIKE ?", "#{params[:nome_paciente]}%").where(empresa_id: current_usuario.empresa_id).take(10)
    end
  end
end
