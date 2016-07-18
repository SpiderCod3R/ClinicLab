module ApplicationHelper

  def status(status)
    if status == 'true'
      'Ativo'
    else
      'Inativo'
    end
  end

  def documento(documento)
    if documento == '1'
    	'Física'
    elsif documento == '2'
    	'Jurídica'
    else
    	''
    end
  end
end
