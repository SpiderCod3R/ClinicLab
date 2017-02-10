json.array!(@pacientes) do |paciente|
  json.extract! paciente, :id,:nome, :rg, :cpf, :telefone, :endereco, :bairro,
                          :complemento, :sexo, :estado_civil, :matricula, :titular,
                          :plano, :email, :produto


  json.set! :nascimento do
    json.data paciente.nascimento.strftime("%d/%m/%Y")
  end

  json.set! :validade_carteira do
    json.data paciente.validade_carteira.strftime("%d/%m/%Y")
  end

  json.set! :cidade do
    if paciente.cidade.present?
      json.id paciente.cidade.id
      json.nome paciente.cidade.nome
    else
      json.null!
    end
  end

  json.set! :estado do
    if paciente.estado.present?
      json.id paciente.estado.id
      json.nome paciente.estado.nome
    else
      json.null!
    end
  end

  json.set! :convenio do
    if paciente.convenio.present?
      json.id paciente.convenio.id
      json.nome paciente.convenio.nome
    end
  end
end