module FormatacoesHelper
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
