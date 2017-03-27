json.array!(@cliente_collection_pdfs) do |pdf|
  json.extract! pdf, :id, :anotacoes, :data, :cliente_id
  json.url cp.pdf.url
end