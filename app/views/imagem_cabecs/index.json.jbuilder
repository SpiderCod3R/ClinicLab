json.array!(@imagem_cabecs) do |imagem_cabec|
  json.extract! imagem_cabec, :id
  json.url imagem_cabec_url(imagem_cabec, format: :json)
end
