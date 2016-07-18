json.array!(@fornecedores) do |fornecedor|
  json.extract! fornecedor, :id, :status, :nome, :cpf, :cnpj, :email, :telefone, :celular, :endereco, :complemento, :bairro, :estado, :cidade
  json.url fornecedor_url(fornecedor, format: :json)
end
