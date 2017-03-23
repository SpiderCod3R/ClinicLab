json.array!(@clientes) do |cliente|
  json.extract! cliente, :id,:nome, :rg, :telefone, :endereco, :bairro,
                          :complemento, :sexo, :estado_civil, :email

  json.set! :cpf do
    json.numero CPF.new(cliente.cpf).formatted
  end

  json.set! :nascimento do
    json.data cliente.nascimento.strftime("%d/%m/%Y")
  end

  json.set! :cidade do
    if cliente.cidade.present?
      json.id cliente.cidade.id
      json.nome cliente.cidade.nome
    else
      json.null!
    end
  end

  json.set! :estado do
    if cliente.estado.present?
      json.id cliente.estado.id
      json.nome cliente.estado.nome
    else
      json.null!
    end
  end
end