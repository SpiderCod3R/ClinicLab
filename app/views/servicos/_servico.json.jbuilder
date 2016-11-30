json.extract! servico, :id, :tipo, :abreviatura, :created_at, :updated_at
json.url servico_url(servico, format: :json)