json.array!(@painel_permissoes) do |painel_permissao|
  json.extract! painel_permissao, :id, :nome, :model_class
  json.url painel_permissao_url(painel_permissao, format: :json)
end
