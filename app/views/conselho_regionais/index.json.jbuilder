json.array!(@conselho_regionais) do |conselho_regional|
  json.extract! conselho_regional, :id, :sigla, :descricao
  json.url conselho_regional_url(conselho_regional, format: :json)
end
