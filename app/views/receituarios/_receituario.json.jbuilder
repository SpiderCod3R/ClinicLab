json.extract! receituario, :id, :nome, :receita, :created_at, :updated_at
json.url receituario_url(receituario, format: :json)