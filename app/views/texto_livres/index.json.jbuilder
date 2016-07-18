json.array!(@texto_livres) do |texto_livre|
  json.extract! texto_livre, :id, :nome, :texto
  json.url texto_livre_url(texto_livre, format: :json)
end
