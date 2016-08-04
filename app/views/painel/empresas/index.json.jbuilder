json.array!(@painel_empresas) do |painel_empresa|
  json.extract! painel_empresa, :id, :nome, :status
  json.url painel_empresa_url(painel_empresa, format: :json)
end
