json.array!(@cabecs) do |cabec|
  json.extract! cabec, :id, :nome, :texto
  json.url cabec_url(cabec, format: :json)
end
