json.array!(@clientes) do |cliente|
  json.extract! cliente, :id, :status, :nome, :cpf, :endereco, :complemento, :bairro, :uf, :cidade
  json.url cliente_url(cliente, format: :json)
end
