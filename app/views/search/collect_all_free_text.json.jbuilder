json.array!(@textos_livres) do |texto_livre|
  json.extract! texto_livre, :id, :nome, :content
end