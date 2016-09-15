module FormatacoesHelper
  def data_formatada(data)
    data.strftime("%d/%m/%Y") if data.present?
  end

  def hora_formatada(hora)
    hora.strftime("%H:%M") if hora.present?
  end

  def data_e_hora_formatada(data, hora)
    if data.present? && hora.present?
      content_tag(:label) do
        data.strftime("%d/%m/%Y") + " - " + hora.strftime("%H:%M")
      end
    end
  end

  def status(status)
    if status == true
      'Ativo'
    else
      'Inativo'
    end
  end

  def ativo_ou_inativo?(resource)
    return resource ? "ATIVO" : "INATIVO"
  end

  def sexo_formatado(s)
    sexo = ''
    if s == 'f'
      sexo = 'Feminino'
    elsif s == 'm'
      sexo = 'Masculino'
    end
  end
end
