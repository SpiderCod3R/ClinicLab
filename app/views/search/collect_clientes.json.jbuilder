json.array!(@clientes) do |cliente|
  json.extract! cliente, :id,:nome, :rg, :telefone, :endereco, :bairro,
                          :complemento, :sexo, :estado_civil, :email, :status,
                          :pai, :mae, :peso, :altura, :nacionalidade, :naturalidade,
                          :cargo_id, :cidade_id, :estado_id


  # binding.pry

  # json.set! :cargo do
  #   if cliente.cargo_id.present?
  #     json.id cliente.cargo.id
  #     json.nome cliente.cargo.nome
  #   else
  #     json.null!
  #   end
  # end

  json.set! :cpf do
    json.numero CPF.new(cliente.cpf).formatted
  end

  json.set! :nascimento do
    json.data cliente.nascimento.strftime("%d/%m/%Y")
  end

  # json.set! :cidade do
  #   if cliente.cidade_id?
  #     json.id cliente.cidade.id
  #     json.nome cliente.cidade.nome
  #   else
  #     json.null!
  #   end
  # end

  # json.set! :estado do
  #   if cliente.estado_id?
  #     json.id cliente.estado.id
  #     json.nome cliente.estado.nome
  #   else
  #     json.null!
  #   end
  # end

  json.set! :convenios do
    if cliente.cliente_convenios.nil?
      json.array!(cliente.cliente_convenios) do |cliente_convenio|
        json.extract! cliente_convenio, :id, :convenio_id, :cliente_id, :matricula, :titular, :plano,
                                        :validade_carteira, :produto, :utilizando_agora
      end
    else
      json.null!
    end
  end
end
