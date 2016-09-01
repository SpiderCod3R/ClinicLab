module ApplicationHelper
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
